#!/usr/bin/env python3
#
# Usage :
#  1. Generate a json file with vulkaninfo :
#     $ intel_stub_gpu -p skl vulkaninfo -j -o skl.json
#  2. Generate feature file :
#     $ ./update_features.py -i /mesa-repo/docs/features.txt -o features.txt -d anv -j skl.json

import argparse
import json
import os
import re

def parse_args():
    p = argparse.ArgumentParser()
    p.add_argument('-i', '--input', type=str, required=True,
                   help='Input file for the features.txt')
    p.add_argument('-o', '--output', type=str,
                   help='Output file for the features.txt')
    p.add_argument('-j', '--json', type=str, required=True,
                   help='Vulkaninfo json file')
    p.add_argument('-d', '--driver', type=str, required=True,
                   help='Driver name')

    pargs = p.parse_args()

    if pargs.output in (None, '-'):
        pargs.output = '/dev/stdout'

    return pargs

def list_has_driver(drvs, name):
    for d in drvs:
        if d.startswith(name):
            return True
    return False

def main():
    pargs = parse_args()

    in_file = open(pargs.input, 'r')
    out_file = open(pargs.output, 'w')
    json_file = open(pargs.json, 'r')

    json_data = json.load(json_file)

    drv_ext_table = json_data['capabilities']['device']['extensions']
    features_ext_table = {}

    lines_before = in_file.readlines()

    regex = re.compile(r"(\s+)(VK_[^\s]+)(\s+)(DONE|not started)(\s+)(.*)")

    lines_after = []
    for l in lines_before:
        r = regex.match(l)
        if r is not None:
            ext_name = r[2]
            status = r[4]
            drv_list = r[6].replace("(", "").replace(")", "").replace(" ", "").split(",")

            features_ext_table[ext_name] = True

            if not list_has_driver(drv_list, pargs.driver) and ext_name in drv_ext_table:
                drv_list.append(pargs.driver)
                drv_list.sort()
                if status == "not started":
                    status = "DONE"
                lines_after.append("{0}{1}{2}{3}{4}({5})\n".format(r[1], ext_name, r[3], status, r[5], ', '.join(drv_list)))
            else:
                lines_after.append(l)
        else:
            lines_after.append(l)

    for k, v in drv_ext_table.items():
        if k not in features_ext_table:
            print("Missing features {0}".format(k))

    for l in lines_after:
        out_file.write(l)

if __name__ == '__main__':
    main()
