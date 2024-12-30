/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  output: 'standalone',
  webpack: (config, { isServer }) => {
    if (isServer) {
      config.devtool = 'source-map';
    }
    return config;
  },
  productionBrowserSourceMaps: true,
};

export default nextConfig;
