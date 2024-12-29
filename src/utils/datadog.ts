import { datadogRum } from '@datadog/browser-rum';
import packageJson from '../../package.json';

export const initDatadog = () =>
  datadogRum.init({
    applicationId: process.env.NEXT_PUBLIC_DDOG_APPLICATION_ID!,
    clientToken: process.env.NEXT_PUBLIC_DDOG_CLIENT_TOKEN!,
    site: process.env.NEXT_PUBLIC_DDOG_SITE,
    service: process.env.NEXT_PUBLIC_DDOG_SERVICE,
    env: process.env.NEXT_PUBLIC_ENV,
    version: packageJson.version,
    sessionSampleRate: 100,
    sessionReplaySampleRate: 100,
    trackUserInteractions: true,
    trackResources: true,
    trackLongTasks: true,
    defaultPrivacyLevel: 'mask-user-input',
  });
