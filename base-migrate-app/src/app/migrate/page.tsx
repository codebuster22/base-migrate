'use client';
import React from 'react';
import StepHeader from './step-header';
import { Logo } from '../../../public/icons';
import Input from '@/components/input';
import { Button } from '@/components';
import MigrationProgress from './progress';
import classNames from 'classnames';

function MigratePage() {
  const [activeStep, setActiveStep] = React.useState(0);

  const nextStep = () => {
    setActiveStep((prev) => prev + 1);
  };

  return (
    <div>
      {activeStep < 2 && <StepHeader activeStep={activeStep} />}
      <div className="p-8 flex items-center justify-center">
        <div
          className={classNames(
            'flex-col border rounded-xl border-grey-200 bg-white-50 inline-flex w-full mx-2 md:mx-0 h-auto p-6',
            {
              'md:w-[552px]': activeStep !== 2,
              'md:w-[448px]': activeStep === 2,
              'mt-20': activeStep > 1,
            },
          )}>
          <div className="flex justify-center pb-6">
            <Logo />
          </div>

          {activeStep === 0 && (
            <>
              <div>
                <Input
                  name="token_name"
                  label="Token Name"
                  placeholder="DAI Stablecoin"
                  onChange={() => {}}
                />
              </div>
              <div>
                <Input
                  name="token_symbol"
                  label="Token Symbol"
                  placeholder="$DAI"
                  onChange={() => {}}
                />
              </div>
              <div>
                <Input
                  name="token_decimal"
                  label="Token Decimal"
                  placeholder="18"
                  onChange={() => {}}
                />
              </div>
              <div>
                <Input
                  name="token_description"
                  label="Token Description"
                  type={'textarea'}
                  placeholder="Token Description"
                  onChange={() => {}}
                />
              </div>
              <div>
                <Input
                  name="token_address"
                  label="Token Address on Ethereum(L1)"
                  placeholder="Token address"
                  onChange={() => {}}
                />
              </div>
              <div className="py-6 flex flex-col justify-center items-center">
                <Button onClick={nextStep} variant="tertiary" text={'Next'} />
              </div>
            </>
          )}

          {activeStep === 1 && (
            <>
              <div>
                <Input
                  name="logo"
                  label="Logo url (must be in SVG format)"
                  placeholder="Add your Logo URL"
                  onChange={() => {}}
                />
              </div>
              <div>
                <Input
                  name="website"
                  label="Website Link"
                  placeholder="www.njokuscript.com"
                  onChange={() => {}}
                />
              </div>
              <div>
                <Input
                  name="twitter"
                  label="Twitter Link"
                  placeholder="www.twitter.com/njokuscript"
                  onChange={() => {}}
                />
              </div>

              <div className="py-6 flex flex-col justify-center items-center">
                <Button onClick={nextStep} variant="tertiary" text={'Migrate to Base'} />
              </div>
            </>
          )}

          {activeStep === 2 && <MigrationProgress next={nextStep} />}

          {activeStep === 3 && (
            <div>
              <div className="md:text-lg text-black-250 text-center font-medium">
                You’re almost Based 🔵
              </div>
              <p className="text-black-300 text-sm md:text-base leading-5 lg:leading-7 text-center mt-4 px-6 md:px-20">
                To complete the migration, submit a pull request to the Superchain token repo list.
              </p>
              <p className="text-black-300 text-sm md:text-base leading-5 lg:leading-7 text-center mt-4 px-6 md:px-20">
                Once your PR is merged, the token list will update automatically to include your
                token and your token will be available on the Base Bridge.
              </p>

              <div className="py-7 flex flex-col justify-center items-center">
                <Button onClick={() => {}} variant="tertiary" text={'Raise Pull Request'} />
              </div>
            </div>
          )}
        </div>
      </div>
    </div>
  );
}

export default MigratePage;
