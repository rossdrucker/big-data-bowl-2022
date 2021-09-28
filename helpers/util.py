# pylint: disable=import-error
"""Utility functions to help with the Big Data Bowl.

This file contains the necessary code to create a valid, timeout-resistant
request through the BeautifulSoup library.
"""
import time
import requests
from requests.adapters import HTTPAdapter
from urllib3.util.retry import Retry
from requests.exceptions import ConnectionError, Timeout

from bs4 import BeautifulSoup

def prepare_request(num_retries=10, timeout=3.1):
    """
    Returns a prepared request with mounted retry and timeout parameters. The
    request will try to access the server num_retries times before returning an
    exception and will timeout after timeout seconds (by convention timeout is
    set to slightly larger than a multiple of 3). A timeout will prompt a
    retry.
    """

    req = requests.Session()

    retries = Retry(total = num_retries,
                    backoff_factor = 10, # Delay of 10 seconds
                    status_forcelist = [500, 502, 503, 504])

    req.mount('http://', HTTPAdapter(max_retries = retries)) # Mount the retry
    req.mount('https://', HTTPAdapter(max_retries = retries))

    # Create class capable of mounting timeouts
    class TimeoutAdapter(HTTPAdapter):
        def __init__(self, timeout=None, *args, **kwargs):
            self.timeout = timeout
            super(TimeoutAdapter, self).__init__(*args, **kwargs)

        def send(self, *args, **kwargs):
            kwargs['timeout'] = self.timeout
            return super(TimeoutAdapter, self).send(*args, **kwargs)


    req.mount('http://', TimeoutAdapter(timeout=timeout)) # Mount the timeout
    req.mount('https://', TimeoutAdapter(timeout=timeout))

    return req

def get_soup(url, num_retries=10, timeout=3.1, proxies=None):
    """
    Tries to send a BeautifulSoup request and return a response from the
    server. Will sleep for 60 seconds and then try again (up to ten times) in
    the case of a Connection Error or Read Timeout error.
    """

    req = prepare_request(num_retries, timeout)

    attempts = 0

    while attempts < 10: # Max of 10 attempts before failing
        try:
            soup = BeautifulSoup(req.get(url, proxies=proxies).text,
                                 'html.parser')
            break
        except (ConnectionError, Timeout) as error:
            print(str(error) + ' -- waiting 30 seconds')
            attempts += 1
            time.sleep(30) # Give some time before trying again
        except:
            raise

    return soup
