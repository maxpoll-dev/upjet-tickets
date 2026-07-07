'use client'

import { useEffect, useState } from 'react'
import { App, Modal, Button, Typography, Row, Col, Input, Form, Spin } from 'antd'
import api from '@/lib/api'
import { useRouter } from 'next/navigation'
import dayjs from 'dayjs'

const { Text } = Typography

interface Seat {
    id: number
    number: number
    status: 'free' | 'occupied'
}

interface SessionDetail {
    id: number
    starts_at: string
    price: number
    currency: string
    movie: string
    room: string
    seats: Seat[]
}

interface Props {
    open: boolean
    sessionId: number | null
    onClose: () => void
}

export default function SeatSelectionModal({ open, sessionId, onClose }: Props) {
    const { message } = App.useApp()
    const [session, setSession] = useState<SessionDetail | null>(null)
    const [selectedSeats, setSelectedSeats] = useState<number[]>([])
    const [submitting, setSubmitting] = useState(false)
    const router = useRouter()

    useEffect(() => {
        if (!open || !sessionId) return

        api.get(`/sessions/${sessionId}`)
            .then(res => setSession(res.data.data))
            .catch((err: { message?: string }) => {
                message.error(err.message || 'Не удалось загрузить сеанс')
                onClose()
            })
    }, [open, sessionId, onClose, message])

    const toggleSeat = (seatId: number) => {
        const seat = session?.seats.find(s => s.id === seatId)
        if (!seat || seat.status === 'occupied') return

        setSelectedSeats(prev =>
            prev.includes(seatId)
                ? prev.filter(id => id !== seatId)
                : [...prev, seatId]
        )
    }

    const handleBook = async (values: { email: string }) => {
        if (!session || selectedSeats.length === 0) return

        setSubmitting(true)

        try {
            const response = await api.post('/orders', {
                movie_session_id: session.id,
                seat_ids: selectedSeats,
                email: values.email,
            })

            const order = response.data.data

            message.success('Бронирование успешно создано!')
            onClose()

            router.push(`/orders/${order.order_id}?token=${order.access_token}`)
        } catch (err: unknown) {
            const e = err as { code?: string; message?: string }
            if (e.code === 'SEATS_TAKEN') {
                const res = await api.get(`/sessions/${session.id}`)
                setSession(res.data.data)
                setSelectedSeats([])
            }
            message.error(e.message || 'Не удалось создать бронь')
        } finally {
            setSubmitting(false)
        }
    }

    const totalPrice = session ? selectedSeats.length * session.price : 0

    return (
        <Modal
            title={session ? `Выбор мест — ${session.movie}` : 'Выбор мест'}
            open={open}
            onCancel={onClose}
            afterClose={() => {
                setSession(null)
                setSelectedSeats([])
            }}
            footer={null}
            width={750}
            centered
        >
            {!session ? (
                <div className="text-center py-10">
                    <Spin />
                </div>
            ) : (
                <>
                    <div className="mb-6">
                        <Text strong>
                            {dayjs(session.starts_at).format('DD.MM.YYYY HH:mm')} • Зал: {session.room}
                        </Text>
                    </div>

                    <div className="bg-gray-100 p-6 rounded-xl mb-6">
                        <Row gutter={[12, 12]} justify="center">
                            {session.seats.map((seat) => {
                                const isSelected = selectedSeats.includes(seat.id)
                                const isOccupied = seat.status === 'occupied'

                                return (
                                    <Col key={seat.id}>
                                        <Button
                                            type={isSelected ? 'primary' : 'default'}
                                            danger={isOccupied}
                                            disabled={isOccupied}
                                            onClick={() => toggleSeat(seat.id)}
                                            className="w-14 h-14 text-base font-semibold"
                                        >
                                            {seat.number}
                                        </Button>
                                    </Col>
                                )
                            })}
                        </Row>
                    </div>

                    <div className="mb-6">
                        <div className="flex justify-between items-center">
                            <Text strong>Выбрано мест: {selectedSeats.length}</Text>
                        </div>
                        <div className="mb-2">
                            <Text strong>Цена: </Text>
                            {selectedSeats.length > 0 && (
                                <Text strong style={{ fontSize: '14px' }}>
                                    {totalPrice} {session.currency}
                                </Text>
                            )}
                        </div>
                    </div>

                    <Form onFinish={handleBook} layout="vertical">
                        <Form.Item
                            label="Email для отправки билетов и информации о заказе"
                            name="email"
                            rules={[
                                { required: true, message: 'Пожалуйста, введите email' },
                                { type: 'email', message: 'Введите корректный email адрес' },
                            ]}
                        >
                            <Input size="large" placeholder="your@email.com" autoFocus />
                        </Form.Item>

                        <Button
                            type="primary"
                            size="large"
                            block
                            htmlType="submit"
                            loading={submitting}
                            disabled={selectedSeats.length === 0}
                        >
                            Забронировать
                        </Button>
                    </Form>
                </>
            )}
        </Modal>
    )
}