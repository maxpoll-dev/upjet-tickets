'use client'

import { use, useEffect, useState } from 'react'
import { useSearchParams } from 'next/navigation'
import { App, Card, Button, Typography, Tag, Spin, Row, Col, Divider } from 'antd'
import api from '@/lib/api'
import dayjs from 'dayjs'

const { Title, Text } = Typography

interface Ticket {
    seat_number: number
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

export default function OrderPage({ params }: { params: Promise<{ id: string }> }) {
    const { id } = use(params)
    const { message } = App.useApp()
    const searchParams = useSearchParams()
    const token = searchParams.get('token')

    const [order, setOrder] = useState<Order | null>(null)
    const [loading, setLoading] = useState(true)
    const [paying, setPaying] = useState(false)

    useEffect(() => {
        if (!token) return

        api.get(`/orders/${id}`, { params: { token } })
            .then(res => setOrder(res.data.data))
            .catch((err: { message?: string }) => message.error(err.message || 'Не удалось загрузить заказ'))
            .finally(() => setLoading(false))
    }, [id, token, message])

    const handlePay = async () => {
        if (!order || !token) return

        setPaying(true)

        try {
            const res = await api.post(`/orders/${order.order_id}/pay`, {}, { params: { token } })
            setOrder({ ...order, status: res.data.data.status })
            message.info('Оплата обрабатывается…')
        } catch (err: unknown) {
            const msg = (err as { message?: string }).message
            message.error(msg || 'Ошибка при оплате')
        } finally {
            setPaying(false)
        }
    }

    if (!token) return <div className="text-center py-20 text-red-500">Заказ не найден или токен недействителен</div>
    if (loading) return <Spin size="large" fullscreen />
    if (!order) return <div className="text-center py-20 text-red-500">Заказ не найден или токен недействителен</div>

    const isPaid = order.status === 'paid'
    const isPending = order.status === 'pending'
    const isExpired = order.status === 'expired'
        || (order.status === 'reserved' && dayjs(order.expires_at).isBefore(dayjs()))
    const canPay = order.status === 'reserved' && !isExpired

    return (
        <div className="max-w-2xl mx-auto p-6">
            <Card className="shadow-xl">
                <div className="text-center mb-8">
                    <Title level={3}>Заказ №{order.order_id}</Title>
                    <Tag
                        color={isPaid ? "green" : isPending ? "processing" : isExpired ? "red" : "gold"}
                        className="text-lg px-6 py-1.5"
                    >
                        {isPaid ? "Оплачено" : isPending ? "Оплата обрабатывается" : isExpired ? "Время истекло" : "Ожидает оплаты"}
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
                        <p className="text-3xl font-bold">
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

                {canPay && (
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

                {isPending && (
                    <div className="text-center py-10">
                        <Spin />
                        <p className="text-xl mt-4">Оплата обрабатывается…</p>
                    </div>
                )}

                {isPaid && (
                    <div className="text-center py-10">
                        <Tag color="green" className="text-2xl px-10 py-3">
                            Заказ успешно оплачен!
                        </Tag>
                    </div>
                )}

                {isExpired && (
                    <div className="text-center py-10 text-red-500">
                        <p className="text-xl font-semibold">Время истекло</p>
                        <p className="text-base mt-2">Время резерва закончилось — заказ больше не действителен. Оформите новую бронь.</p>
                    </div>
                )}
            </Card>
        </div>
    )
}