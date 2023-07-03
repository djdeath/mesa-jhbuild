import argparse
import json
import os
import re

def parse_args():
    p = argparse.ArgumentParser()
    p.add_argument('-i', '--input', type=str,
                   help='Input file for the features.txt')
    p.add_argument('-o', '--output', type=str,
                   help='Output file for the features.txt')
    p.add_argument('-j', '--json', type=str,
                   help='Vulkaninfo json file')

    pargs = p.parse_args()

    if pargs.output in (None, '-'):
        pargs.output = '/dev/stdout'

    return pargs

def list_has_anv(drvs):
    for d in drvs:
        if 'anv' in d:
            return True
    return False

def main():
    pargs = parse_args()

    in_file = open(pargs.input, 'r')
    out_file = open(pargs.output, 'w')
    json_file = open(pargs.json, 'r')

    json_data = json.load(json_file)

    ext_table = {}
    for ext in json_data['ArrayOfVkExtensionProperties']:
        ext_table[ext['extensionName']] = True

    lines_before = in_file.readlines()

    regex = re.compile(r"(\s+)(VK_[^\s]+)(\s+)(DONE|not started)(\s+)(.*)")

    lines_after = []
    for l in lines_before:
        r = regex.match(l)
        if r is not None:
            ext_name = r[2]
            status = r[4]
            drv_list = r[6].replace("(", "").replace(")", "").replace(" ", "").split(",")

            if not list_has_anv(drv_list) and ext_name in ext_table:
                drv_list.append('anv')
                print(drv_list)
                drv_list.sort()
                print(drv_list)
                if status == "not started":
                    status = "DONE"
                lines_after.append("{0}{1}{2}{3}{4}({5})\n".format(r[1], ext_name, r[3], status, r[5], ', '.join(drv_list)))
            else:
                lines_after.append(l)
        else:
            lines_after.append(l)

    for l in lines_after:
        out_file.write(l)

if __name__ == '__main__':
    main()
