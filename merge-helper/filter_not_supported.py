#! /usr/bin/env python3

import json

def main():
    supported = json.load(open('supported.json'))

    body = False
    lines = open('legacy.manifest').readlines()
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

        if t[0] in supported:
            continue

        print(ls)

if __name__ == "__main__":
    main()
