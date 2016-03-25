#!/usr/bin/python

# @author Christopher Hunter <christopher.hunter@bigfishgames.com>
# @copyright 2016
from __future__ import absolute_import

import argparse
import getpass
import os
import sys
from shutil import rmtree
import urllib2

def get_active_jobs(opener):
    request = urllib2.Request(URL)
    json = opener.open(request)
    return [job['name'] for job in eval(json.read())['jobs']]

def get_jobs_dir():
    return os.walk('.').next()[1]

def __main__():
    '''
    Connect to the Jenkins Python API and get a list of valid jobs. Then walk
    the Jenkins job folder on disk and compare to generate a list of jobs that
    are on the disk but not configured in Jenkins.
    '''

    # Parse arguments and setup options
    BFGsiteURL = 'http://build-master01.qast.bigfishgames.com:8080'
    apiURL ='/api/python?tree=jobs[name]'

    parser = argparse.ArgumentParser(formatter_class=argparse.RawTextHelpFormatter)
    parser.add_argument("-u", "--username",  action="store_true",
                        required=True, help="username for Jenkins API")
    parser.add.argument("-r", "--rootURL", action="store_true",
                        required=False, help="root URL for jenkins site")

    args = parser.parse_args()
    USER = args.username
    PASS = getpass.getpass()
    if rootURL is None:
        siteURL = BFGsiteURL
    URL = siteURL + apiURL

    # Do the API work
    passman = urllib2.HTTPPasswordMgrWithDefaultRealm()
    passman.add_password(None, URL, USER, PASS)
    authhandler = urllib2.HTTPBasicAuthHandler(passman)
    opener = urllib2.build_opener(authhandler)
    jobs = get_active_jobs(opener)

    jobs_in_dir = get_jobs_dir()
    jobs_to_delete = sorted([job for job in jobs_in_dir if job not in jobs])
    for job in jobs_to_delete:
        print("%s" % (job))

if __name__ == '__main__':
    sys.exit(main())
