#!/usr/bin/env python3
# -*- coding:utf-8 -*-
import boto3
def get_hosts(region):
    ec2 = boto3.resource('ec2', region_name=region)
    instances = [x for x in ec2.instances.iterator()]
    get_tags = lambda y: {x['Key'].lower(): x['Value'] for x in y.tags}
    for instance in instances:
        try:
            tags = get_tags(instance)
        except:
            continue
        name = tags.get('name')
        instance_id = instance.id
        fqdn = tags.get('fqdn')
        if not name: continue
        if not fqdn:
            fqdn = "%(name)s-%(instance_id)s.%(region)s.stuart" % locals()
        print('Host %s' %fqdn)
        print('\tHostname %s' %instance.private_ip_address)
        print('\tUser deploy')
        print('\tStrictHostKeyChecking no')
        print()

if __name__ == '__main__':
    get_hosts('eu-west-1')
    get_hosts('eu-central-1')
