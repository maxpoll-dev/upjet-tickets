'use client'

import { useEffect, useState } from 'react'
import { useSearchParams } from 'next/navigation'
import { Card, Button, Typography, Tag, Spin, message, Row, Col, Divider } from 'antd'
import api from '@/lib/api'
import dayjs from 'dayjs'

const { Title, Text } = Typography

interface Ticket {
    seat_number: string
    movie: string
    room: string
    starts_at: string
}

interface Order {
    order_id: number
    status: string
    email: string
    amount_total: number
    currency: string
    expires_at: string
    paid_at: string | null
    tickets: Ticket[]
}

export default function OrderPage({ params }: { params: { id: string } }) {
    const searchParams = useSearchParams()
    const token = searchParams.get('token')

    const [order, setOrder] = useState<Order | null>(null)
    const [loading, setLoading] = useState(true)
    const [paying, setPaying] = useState(false)

    useEffect(() => {
        if (!token) {
            void message.error('Заказ не найден')
            return
        }

        void fetchOrder()
    }, [params.id, token])

    const fetchOrder = async () => {
        try {
            const res = await api.get(`/orders/${params.id}`, {
                params: { token },
            })

            setOrder(res.data.data)
        } catch (err: any) {
            message.error(err.message || 'Не удалось загрузить заказ')
        } finally {
            setLoading(false)
        }
    }

    const handlePay = async () => {
        if (!order || !token) return

        setPaying(true)

        try {
            const res = await api.post(`/orders/${order.order_id}/pay`, {}, {
                params: { token },
            });

            message.success('Оплата прошла успешно!');
            setOrder(res.data.data)
        } catch (err: any) {
            message.error(err.message || 'Ошибка при оплате')
        } finally {
            setPaying(false)
        }
    }

    if (loading) return <Spin size="large" fullscreen />
    if (!order) return <div className="text-center py-20 text-red-500">Заказ не найден или токен недействителен</div>

    const isExpired = dayjs(order.expires_at).isBefore(dayjs())
    const isPaid = order.status === 'paid'

    return (
        <div className="max-w-2xl mx-auto p-6">
            <Card className="shadow-xl">
                <div className="text-center mb-8">
                    <Title level={3}>Заказ №{order.order_id}</Title>
                    <Tag
                        color={isPaid ? "green" : isExpired ? "red" : "processing"}
                        className="text-lg px-6 py-1.5"
                    >
                        {isPaid ? "Оплачено" : isExpired ? "Истекло время" : "Ожидает оплаты"}
                    </Tag>
                </div>

                <Divider />

                <Row gutter={[16, 16]}>
                    <Col span={12}>
                        <Text type="secondary">Email</Text>
                        <p className="text-lg font-medium">{order.email}</p>
                    </Col>
                    <Col span={12}>
                        <Text type="secondary">Сумма к оплате</Text>
                        <p className="text-3xl font-bold text-white">
                            {order.amount_total} {order.currency}
                        </p>
                    </Col>
                </Row>

                <Divider />

                <Title level={5} className="mb-4">Билеты</Title>
                {order.tickets.map((ticket, index) => (
                    <Card key={index} className="mb-4" size="small">
                        <Row gutter={16}>
                            <Col span={6}>
                                <Text strong>Место</Text>
                                <p className="text-2xl font-semibold">{ticket.seat_number}</p>
                            </Col>
                            <Col span={18}>
                                <Text strong>{ticket.movie}</Text>
                                <br />
                                <Text type="secondary">
                                    {ticket.room} • {dayjs(ticket.starts_at).format('DD.MM.YYYY HH:mm')}
                                </Text>
                            </Col>
                        </Row>
                    </Card>
                ))}

                <Divider />

                {!isPaid && !isExpired && (
                    <Button
                        type="primary"
                        size="large"
                        block
                        onClick={handlePay}
                        loading={paying}
                        className="h-14 text-lg font-medium"
                    >
                        Оплатить {order.amount_total} {order.currency}
                    </Button>
                )}

                {isPaid && (
                    <div className="text-center py-10">
                        <Tag color="green" className="text-2xl px-10 py-3">
                            Заказ успешно оплачен!
                        </Tag>
                    </div>
                )}

                {isExpired && !isPaid && (
                    <div className="text-center py-10 text-red-500">
                        <p className="text-xl">Время на оплату истекло</p>
                    </div>
                )}
            </Card>
        </div>
    )
}
