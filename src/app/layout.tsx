import type { Metadata } from "next";
import { Inter } from "next/font/google";
import "@/styles/globals.css";
import "@/styles/nav.css";
import Head from "next/head";


const inter = Inter({ subsets: ["latin"] });

export const metadata: Metadata = {
  title: 'Reserva Feliz',
  description: 'Alquiler de propiedades ubicados en Colombia',
  applicationName: 'PROPIEDADES VIAJE FELIZ APP - BDA2',
  creator: 'Manuel Fino Aroca - 20191578044',
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="es-co">      
        <body className={inter.className}>
          <Head>    
            {children}
          </Head>
          <h1>NavBar</h1>
          <div className="h-[calc(100 vh-5rem)] container mx-auto">
          {children}
          </div>
        </body>
      </html>
  );
}
