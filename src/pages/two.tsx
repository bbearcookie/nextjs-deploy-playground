import { InferGetServerSidePropsType } from 'next';
import Link from 'next/link';
import React from 'react';

const Page = ({
  text,
}: InferGetServerSidePropsType<typeof getServerSideProps>) => {
  return (
    <div>
      <h1>{text}</h1>
      <Link href="/one">/One 이동</Link>
      <Link href="/two">/Two 이동</Link>
    </div>
  );
};

export default Page;

export const getServerSideProps = async () => {
  await new Promise((resolve) => setTimeout(resolve, 1000));

  return {
    props: {
      text: 'two page!',
    },
  };
};
