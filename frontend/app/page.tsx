'use client'

import { useEffect, useState } from 'react'
import { Card, Row, Col, Typography, Spin, Alert } from 'antd'
import Link from 'next/link'
import api from '@/lib/api'

const { Title } = Typography

interface Movie {
    id: number
    title: string
}

export default function Home() {
    const [movies, setMovies] = useState<Movie[]>([])
    const [loading, setLoading] = useState(true)
    const [error, setError] = useState<string | null>(null)

    useEffect(() => {
        api.get('/movies')
            .then(res => setMovies(res.data.data))
            .catch(err => setError(err.message))
            .finally(() => setLoading(false))
    }, [])

    if (loading) return <Spin size="large" fullscreen />
    if (error) return <Alert type="error" title={error} />

    return (
        <div className="p-8">
            <Title level={2} className="mb-8 text-white">Фильмы</Title>
            <Row gutter={[16, 16]}>
                {movies.map(movie => (
                    <Col key={movie.id} xs={24} sm={12} lg={8}>
                        <Link href={`/movies/${movie.id}`}>
                            <Card hoverable className="h-full">
                                <Card.Meta title={movie.title} />
                            </Card>
                        </Link>
                    </Col>
                ))}
            </Row>
        </div>
    )
}
