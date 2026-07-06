import './globals.css'

import type { Metadata } from 'next'
import { AntdRegistry } from '@ant-design/nextjs-registry'
import { App, ConfigProvider } from 'antd'
import ruRU from 'antd/locale/ru_RU'

export const metadata: Metadata = {
  title: "Awesome Tickets",
  description: "Buy awesome tickets for your own tickets",
}

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode
}>) {
  return (
      <html lang="ru">
      <body>
      <AntdRegistry>
          <ConfigProvider locale={ruRU} theme={{ token: { colorPrimary: '#1677ff' } }}>
              <App>
                  <div style={{ maxWidth: 960, margin: '0 auto', padding: '24px 16px' }}>
                      {children}
                  </div>
              </App>
          </ConfigProvider>
      </AntdRegistry>
      </body>
      </html>
  )
}
