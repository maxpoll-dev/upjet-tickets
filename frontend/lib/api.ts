import axios from 'axios'

const api = axios.create({
    baseURL: process.env.NEXT_PUBLIC_API_URL,
    headers: { 'Content-Type': 'application/json' },
})

api.interceptors.response.use(
    (response) => response,
    (error) => {
        const errData = error.response?.data || {}
        const status = error.response?.status || 500
        const code = errData.code || 'UNKNOWN_ERROR'
        const message = errData.message || 'Unknown error'

        return Promise.reject({ status, code, message })
    }
)

export default api