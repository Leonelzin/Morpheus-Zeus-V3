# Python built-in modules
import argparse
import logging
import os
import time
import shutil
import sys

# Python third party modules
from robot import run_cli
import requests

# Python local modules
import environment
import tests_to_run

logger = logging.getLogger('morpheus')


def main():
    setup_logger()

    logger.info('---   INIT   ---')
    logger.info('Initializing Morpheus')
    execution_unix_timestamp = time.time()
    logger.info(f'Test execution UNIX timestamp: {execution_unix_timestamp}')

    check_os_environment_variables()

    parser = argparse.ArgumentParser()
    parser.add_argument('-d', '--device',
                        help='device to test',
                        required=False)
    parser.add_argument('-o', '--output-dir',
                        help='directory to place test execution report',
                        required=False)

    args = parser.parse_args()

    dut_info = get_dut_info()

    tests = parse_tests()

    if args.device:
        logger.info(f'DUT profile manually set through command line: {args.device}')
        dut_profile = args.device
    else:
        logger.info('DUT profile will be evaluated in runtime')
        dut_profile = evaluate_dut_profile_filepath(dut_info['model_name'])
        logger.info(f'DUT profile evaluated: {dut_profile}')

    if args.output_dir:
        logger.info(f'Test execution report directory manually set through command line: {args.output_dir}')
        report_dir = args.output_dir
    else:
        logger.info('Test execution report directory will be evaluated in runtime')
        report_dir_name = generate_report_directory_name(
            dut_info['model_name'],
            dut_info['firmware_version'],
            int(execution_unix_timestamp)
        )
        report_dir = f'reports/{report_dir_name}'

    logger.info(f'Test execution report directory set: {report_dir}')

    command = ['-d', report_dir,
               '-L', 'TRACE:INFO',
               '-P', 'libraries/',
               '-P', 'resources/',
               '-V', 'environment.py',
               '-V', dut_profile] + tests

    command.append('tests/')

    logger.info('Invoking Robot Framework test execution')
    logger.info(f'Robot Framework command: {command}')

    run_cli(command, exit=False)

    logger.info('Test execution finished, exiting now')
    shutil.copyfile('morpheus.log', f'{report_dir}/morpheus.log')


def setup_logger():
    logger_fmt = logging.Formatter('[%(asctime)s] [ %(levelname)-8s ] %(message)s')

    logger_sh = logging.StreamHandler()
    logger_sh.setFormatter(logger_fmt)

    logger_fh = logging.FileHandler('morpheus.log', mode='w')
    logger_fh.setFormatter(logger_fmt)

    logger.addHandler(logger_sh)
    logger.addHandler(logger_fh)

    logger.setLevel('INFO')


def parse_tests() -> list:
    logger.info('Evaluating tests that will be executed')
    logger.info('Parsing tests from <morpheus/tests_to_run.py>')

    tests = []

    for tag in tests_to_run.INCLUDE_TAGS:
        tests.append('--include')
        tests.append(str(tag))

    for tag in tests_to_run.EXCLUDE_TAGS:
        tests.append('--exclude')
        tests.append(str(tag))

    for suite in tests_to_run.SUITES:
        tests.append('--suite')
        tests.append(str(suite))

    for test_name in tests_to_run.TESTS_BY_NAME:
        tests.append('--test')
        tests.append(str(test_name))

    logger.info(f'Tests parsed: {tests}')

    return tests


def check_os_environment_variables():
    logger.info('Checking environment variables')
    try:
        os.environ['ITB_DEV_FW_PASSWORD']
        logger.info('Environment variable <ITB_DEV_FW_PASSWORD> is set')
        logger.info('Environment variables OK')
    except KeyError as missing_key:
        logger.error('Environment variable check failed (missing variable).')
        logger.error(f'Environment variable missing: {missing_key}')
        logger.critical('Aborting test execution (exception will be raised).')
        raise


def get_dut_url():
    logger.info('Evaluating DUT management information (from <morpheus/environment.py>)')

    if environment.DUT_ENV['management']['http']['secure'] == True:
        dut_mgmt_web_protocol = 'https'
    else:
        dut_mgmt_web_protocol = 'http'

    dut_mgmt_ipv4_address = environment.DUT_ENV['management']['ipv4_address']
    dut_mgmt_http_port = environment.DUT_ENV['management']['http']['port']
    dut_url = f'{dut_mgmt_web_protocol}://{dut_mgmt_ipv4_address}:{dut_mgmt_http_port}'

    logger.info(f'DUT management WEB protocol: {dut_mgmt_web_protocol}')
    logger.info(f'DUT management IPv4 address: {dut_mgmt_ipv4_address}')
    logger.info(f'DUT management HTTP port: {dut_mgmt_http_port}')
    logger.info(f'DUT management URL: {dut_url}')

    return dut_url


def get_dut_info():
    dut_url = get_dut_url()

    logger.info('Retrieving DUT information through REST API call')
    logger.info('DUT API endpoint: /cgi-bin/api/v3/system/device/info')

    api_response = requests.get(f'{dut_url}/cgi-bin/api/v3/system/device/info')

    logger.info(f'DUT API response: {api_response.content}')

    dut_info = {
        'model_name': api_response.json()['data']['model'],
        'firmware_version': api_response.json()['data']['version']
    }

    logger.info(f'DUT information: {dut_info}')

    return dut_info


def sanitize_dut_model_name(dut_model):
    sanitized_dut_model = dut_model.translate(
        str.maketrans(
            {
                ' ': '',
                '/': '',
                '\\': ''
            }
        )
    )

    return sanitized_dut_model


def generate_report_directory_name(dut_model, dut_firmware_version, unix_timestamp):
    logger.info(f'Creating test execution report directory name')
    logger.info(f'DUT model name (original): {dut_model}')

    dut_model = sanitize_dut_model_name(dut_model)

    logger.info(f"DUT model name (after removing spaces, '/' and '\\'): {dut_model}")

    report_directory_name = f'{dut_model}_{dut_firmware_version}_{unix_timestamp}'

    logger.info(f'Test execution report directory name created: {report_directory_name}')

    return report_directory_name


def evaluate_dut_profile_filepath(dut_model):
    dut_profile_filename = sanitize_dut_model_name(dut_model)
    dut_profile = f'devices/{dut_profile_filename}.py'

    if not os.path.isfile(dut_profile):
        logger.error(f'Evaluated DUT profile does not exist: {dut_profile}')
        logger.critical('Aborting test execution (exception will be raised).')
        raise FileNotFoundError(dut_profile)

    return dut_profile


if __name__ == '__main__':
    main()
