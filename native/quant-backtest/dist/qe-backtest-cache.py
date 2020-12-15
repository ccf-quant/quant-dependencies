#!/usr/bin/env python

import os
import re
from dataclasses import dataclass
from typing import *

import click
import mltk
import redis


class EngineConfig(mltk.Config):
    class back_test(mltk.Config):
        class cache(mltk.Config):
            redis_host: Optional[str]
            redis_port: int = 6379
            redis_db: int = 0
            redis_prefix: str = 'qe-backtest'
            all_codes: bool = True

        class options(mltk.Config):
            code_set: str = '*'


@dataclass
class Context(object):
    KEY_PATTERN = re.compile(
        r'^PriceSnapshot:'
        r'(?P<code_set>[^\-]+)-'
        r'(?P<option>HIGH|LOW|OPEN|CLOSE|AVERAGE|MEDIAN)-'
        r'(?P<start_date>\d{14})-'
        r'(?P<end_date>\d{14})$'
    )

    config: EngineConfig.back_test
    redis: redis.Redis

    def cache_keys(self) -> Generator[str, None, None]:
        prefix = f'{self.config.cache.redis_prefix}:'
        prefix_len = len(prefix)
        for key in self.redis.keys(f'{prefix}*'.encode('utf-8')):
            yield key.decode('utf-8')[prefix_len:]

    def get_cache(self, key: str) -> bytes:
        key = f'{self.config.cache.redis_prefix}:{key}'
        return self.redis.get(key.encode('utf-8'))

    def del_cache(self, key: str) -> None:
        key = f'{self.config.cache.redis_prefix}:{key}'
        self.redis.delete(key.encode('utf-8'))

    def split_key(self, key: str) -> Optional[Dict[str, Any]]:
        m = self.KEY_PATTERN.match(key)
        if m:
            return m.groupdict()


@click.group()
@click.option('-C', '--config-file', required=False, default=None)
@click.pass_context
def main(ctx, config_file):
    if not config_file:
        for path in [os.path.expanduser('~/.quant_engine.yml'),
                     '/etc/quant_engine.yml']:
            if os.path.isfile(path):
                config_file = path
                break

    if not config_file:
        raise ValueError('`--config-file` is required.')

    config_loader = mltk.ConfigLoader(EngineConfig)
    config_loader.load_file(config_file)
    config = config_loader.get()
    o = mltk.Config(
        cache=config.back_test.cache,
        options=config.back_test.options,
    )
    print(mltk.format_config(o, title='Cache Configurations'))
    print('')

    if config.back_test.cache.redis_host is None:
        print('No cache server is configured, program exit.')
        exit(0)

    ctx.obj = Context(
        config=config.back_test,
        redis=redis.Redis(
            host=config.back_test.cache.redis_host,
            port=config.back_test.cache.redis_port,
            db=config.back_test.cache.redis_db,
        ),
    )


@main.command()
@click.option('--code-set', required=False, default=None)
@click.pass_obj
def ls(ctx: Context, code_set):
    for key in ctx.cache_keys():
        key_group = ctx.split_key(key)
        if key_group:
            if code_set is None or code_set == key_group['code_set']:
                print(f'Item key={key!r}, {", ".join("{}={!r}".format(k, v) for k, v in key_group.items())}')


@main.command()
@click.option('--code-set', required=False, default=None)
@click.pass_obj
def purge(ctx: Context, code_set):
    for key in ctx.cache_keys():
        key_group = ctx.split_key(key)
        if key_group:
            if code_set is None or code_set == key_group['code_set']:
                print(f'Delete key={key!r}, {", ".join("{}={!r}".format(k, v) for k, v in key_group.items())}')
                ctx.del_cache(key)


if __name__ == '__main__':
    main()
