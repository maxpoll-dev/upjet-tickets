'use client'

import { useCallback, useEffect, useState } from 'react'
import { App, Card, Button, Typography, Row, Col } from 'antd'
import SeatSelectionModal from '@/components/SeatSelectionModal'
import api from '@/lib/api'
import dayjs from 'dayjs'
import { useParams } from 'next/navigation'

interface Session {
    id: number
    starts_at: string
    price: number
    currency: string
}

interface Movie {
    id: number
    title: string
    sessions: Session[]
}

export default function MoviePage() {
    const { message } = App.useApp()
    const [movie, setMovie] = useState<Movie | null>(null)
    const [selectedSessionId, setSelectedSessionId] = useState<number | null>(null)
    const [modalOpen, setModalOpen] = useState(false)

    const params = useParams()
    const movieId = params.id as string

    useEffect(() => {
        api.get(`/movies/${movieId}`)
            .then(res => setMovie(res.data.data))
            .catch((err: { message?: string }) => message.error(err.message))
    }, [movieId, message])

    const openSeatModal = (sessionId: number) => {
        setSelectedSessionId(sessionId)
        setModalOpen(true)
    }

    const closeSeatModal = useCallback(() => setModalOpen(false), [])

    return (
        <div className="p-8">
            <Typography.Title>{movie?.title}</Typography.Title>

            <Row gutter={[16, 16]}>
                {(movie?.sessions ?? []).map(session => (
                    <Col key={session.id} span={24} md={12} lg={8}>
                        <Card>
                            <p><strong>Время:</strong> {dayjs(session.starts_at).format('DD.MM.YYYY HH:mm')}</p>
                            <p><strong>Цена:</strong> {session.price} {session.currency}</p>

                            <Button
                                type="primary"
                                block
                                onClick={() => openSeatModal(session.id)}
                            >
                                Выбрать места
                            </Button>
                        </Card>
                    </Col>
                ))}
            </Row>

            <SeatSelectionModal
                open={modalOpen}
                sessionId={selectedSessionId}
                onClose={closeSeatModal}
            />
        </div>
    )
}