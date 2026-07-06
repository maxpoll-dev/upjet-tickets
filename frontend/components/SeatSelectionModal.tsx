'use client'

import { useState, useEffect } from 'react'
import { Modal, Button, Typography, message, Row, Col, Tag, Input, Form } from 'antd'
import api from '@/lib/api'
import { useRouter } from 'next/navigation'
import dayjs from 'dayjs'

const { Text } = Typography

interface Seat {
    id: number
    number: string
    status: 'free' | 'occupied'
}

interface Session {
    id: number
    starts_at: string
    price: number
    room: string
    movie?: { title: string }
    seats: Seat[]
}

interface Props {
    open: boolean
    session: Session | null
    onClose: () => void
}

export default function SeatSelectionModal({ open, session, onClose }: Props) {
    const [form] = Form.useForm()
    const [selectedSeats, setSelectedSeats] = useState<number[]>([])
    const [loading, setLoading] = useState(false)
    const router = useRouter()

    useEffect(() => {
        if (!open) {
            form.resetFields()
            setSelectedSeats([])
        }
    }, [open])

    const toggleSeat = (seatId: number) => {
        if (!(session) || session.seats.find(s => s.id === seatId)?.status === 'occupied') return

        setSelectedSeats(prev =>
            prev.includes(seatId)
                ? prev.filter(id => id !== seatId)
                : [...prev, seatId]
        )
    }

    const handleBook = async (values: { email: string }) => {
        if (!session || selectedSeats.length === 0) return

        setLoading(true)

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
        } catch (err: any) {
            message.error(err.message || 'Не удалось создать бронь')
        } finally {
            setLoading(false)
        }
    }

    if (!session) return null

    const totalPrice = selectedSeats.length * session.price

    return (
        <Modal
            title={`Выбор мест — ${session.movie?.title}`}
            open={open}
            onCancel={onClose}
            footer={null}
            width={750}
            centered
        >
            <div className="mb-6">
                <Text strong>
                    {dayjs(session.starts_at).format('DD.MM.YYYY HH:mm')} • Зал: {session.room}
                </Text>
            </div>

            <div className="bg-gray-900 p-6 rounded-xl mb-6">
                <Row gutter={[12, 12]} justify="center">
                    {session.seats.map((seat) => {
                        const isSelected = selectedSeats.includes(seat.id)
                        const isOccupied = seat.status === 'occupied'

                        return (
                            <Col key={seat.id}>
                                <Button
                                    type={isSelected ? "primary" : "default"}
                                    danger={isOccupied}
                                    disabled={isOccupied}
                                    onClick={() => toggleSeat(seat.id)}
                                    className="w-14 h-14 text-base font-semibold"
                                >
                                    {seat.number}
                                </Button>
                            </Col>
                        );
                    })}
                </Row>
            </div>

            <div className="mb-6">
                <div className="flex justify-between items-center mb-2">
                    <Text strong>Выбрано мест: {selectedSeats.length}</Text>
                    {selectedSeats.length > 0 && (
                        <Text strong style={{ fontSize: '18px' }}>
                            {totalPrice} ₽
                        </Text>
                    )}
                </div>
                <Tag color="green">Свободно</Tag>
                <Tag color="red">Занято</Tag>
            </div>

            <Form
                form={form}
                onFinish={handleBook}
                layout="vertical"
            >
                <Form.Item
                    label="Email для отправки билетов и информации о заказе"
                    name="email"
                    rules={[
                        { required: true, message: 'Пожалуйста, введите email' },
                        { type: 'email', message: 'Введите корректный email адрес' },
                    ]}
                >
                    <Input
                        size="large"
                        placeholder="your@email.com"
                        autoFocus
                    />
                </Form.Item>

                <Button
                    type="primary"
                    size="large"
                    block
                    htmlType="submit"
                    loading={loading}
                    disabled={selectedSeats.length === 0}
                >
                    Забронировать {selectedSeats.length > 0 ? `(${selectedSeats.length} мест)` : ''}
                </Button>
            </Form>
        </Modal>
    )
}
