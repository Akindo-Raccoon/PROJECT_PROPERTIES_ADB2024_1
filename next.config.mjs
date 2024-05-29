/** @type {import('next').NextConfig} */
const nextConfig = {
    async redirects() {
        return [
            {
                source: "/",
                destination: "/properties",
                permanent: true,
            },
        ]
    },
};

export default nextConfig;
