#! /usr/bin/env python3

import json

def main():
    supported = []

    body = False
    lines = open('experimental.manifest').readlines()
    for l in lines:
        ls = l.strip()
        
        if ls == '':
            body = True
            continue

        if ls == '---':
            break

        if not body:
            continue

        t = ls.split(' ')

        supported.append(t[0])

    supported.sort()

    print(json.dumps(supported, indent=4))

if __name__ == "__main__":
    main()
