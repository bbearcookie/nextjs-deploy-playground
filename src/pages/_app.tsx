import '@/styles/globals.css';

import type { AppProps } from 'next/app';
import packageJson from '../../package.json';
import Head from 'next/head';

export default function App({ Component, pageProps }: AppProps) {
  return (
    <>
      <Head>
        <title>Next.js Deploy Playground - ${packageJson.version}</title>
      </Head>
      <div>버전: {packageJson.version}</div>
      <Component {...pageProps} />
    </>
  );
}
