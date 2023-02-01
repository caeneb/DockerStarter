#!/usr/bin/env python
import click
import logging
import datetime
from logging.config import dictConfig

logging_config = dict(
    version=1,
    formatters={
        'f': {'format': '%(asctime)s [%(levelname)s] - [%(filename)s > %(funcName)s > %(lineno)d] - %(message)s'},
        'c': {'format': '%(asctime)s - %(message)s'},
    },
    handlers={
        'f': {
            'class': 'logging.FileHandler', 'formatter': 'f', 'level': logging.INFO,
            'filename': f'/bind/log/{datetime.datetime.now().isoformat().replace(":", "_")}.log', 'mode': 'a'
        },
        'c': {'class': 'logging.StreamHandler', 'formatter': 'c', 'level': logging.DEBUG},
    },
    root={
        'handlers': ['f', 'c'],
        'level': logging.DEBUG,
    },
    disable_existing_loggers=False,
)

dictConfig(logging_config)
logging.getLogger(__name__)


@click.group()
def cli():
    pass


if __name__ == '__main__':
    cli().run()
