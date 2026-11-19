FROM odoo:20.0

USER root

RUN apt-get update \
    && apt-get install -y --no-install-recommends postgresql-client \
    && rm -rf /var/lib/apt/lists/*

COPY ./custom_addons /mnt/extra-addons
COPY ./odoo.conf /etc/odoo/odoo.conf

RUN chown -R odoo:odoo /mnt/extra-addons /etc/odoo/odoo.conf

USER odoo

CMD ["sh", "-c", "psql -h ep-lucky-morning-bb41rsxr.c-15.us-east-1.aws.
neon.tech -p 5432 -U neondb_owner -d neondb -c \"DELETE FROM ir_attachment WHERE url LIKE '/web/assets/%';\" || true; exec odoo -c /etc/odoo/odoo.conf -d neondb -i base,ventas_unicah --without-demo=all"]
