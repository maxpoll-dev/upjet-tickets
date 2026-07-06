'use client'

import { useEffect, useState } from 'react'
import { Card, Button, Typography, Row, Col, message } from 'antd'
import SeatSelectionModal from '@/components/SeatSelectionModal'
import api from '@/lib/api'
import dayjs from 'dayjs'

interface Session {
    id: number
    starts_at: string
    price: number
    room: string
    seats: any[]
}

export default function MoviePage({ params }: { params: { id: string } }) {
    const [movie, setMovie] = useState<any>(null)
    const [sessions, setSessions] = useState<Session[]>([])
    const [selectedSession, setSelectedSession] = useState<Session | null>(null)
    const [modalOpen, setModalOpen] = useState(false)

    useEffect(() => {
        api.get(`/movies/${params.id}`)
            .then(res => {
                setMovie(res.data.data);
                setSessions(res.data.data.sessions || [])
            })
            .catch(err => message.error(err.message))
    }, [params.id])

    const openSeatModal = (session: Session) => {
        setSelectedSession(session)
        setModalOpen(true)
    }

    return (
        <div className="p-8">
            <Typography.Title>{movie?.title}</Typography.Title>

            <Row gutter={[16, 16]}>
                {sessions.map(session => (
                    <Col key={session.id} span={24} md={12} lg={8}>
                        <Card>
                            <p><strong>Время:</strong> {dayjs(session.starts_at).format('DD.MM.YYYY HH:mm')}</p>
                            <p><strong>Зал:</strong> {session.room}</p>
                            <p><strong>Цена:</strong> {session.price} ₽</p>

                            <Button
                                type="primary"
                                block
                                onClick={() => openSeatModal(session)}
                            >
                                Выбрать места
                            </Button>
                        </Card>
                    </Col>
                ))}
            </Row>

            <SeatSelectionModal
                open={modalOpen}
                session={selectedSession}
                onClose={() => setModalOpen(false)}
            />
        </div>
    )
}
