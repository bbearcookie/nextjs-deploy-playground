import '@/styles/globals.css';

import type { AppProps } from 'next/app';
import packageJson from '../../package.json';
import Head from 'next/head';
import { initDatadog } from '@/utils/datadog';

initDatadog();

export default function App({ Component, pageProps }: AppProps) {
  return (
    <>
      <Head>
        <title>Next.js Deploy Playground</title>
      </Head>
      <div>버전: {packageJson.version}</div>
      <div>URL: {process.env.NEXT_PUBLIC_URL}</div>
      <Component {...pageProps} />
    </>
  );
}
