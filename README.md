# Base docker image for Odoo OpenUpgrade
Basically this image is base image which prepares running environment for Odoo OpenUpgrade to migrate odoo 10 to odoo 11.

# Usage
To use this image, just use create another image by extending from this image. The migration scripts from OpenUpgrade should be copied to the /var/lib/odoo directory and additional addons should be copied to /var/lib/odoo/more-addons directory. e.g.

    COPY ./openupgrade10to11/ /var/lib/odoo
    COPY ./my-addons/ /var/lib/odoo/more-addons

## Running
After building the new image, use the "migrate" command to migrate data.

## Environment Variables
* HOST - Database Host (default value : db)
* PORT - Database Port (default value : 5432)
* USER - Database User (default value : odoo)
* PASSWORD - Database Password (default value : odoo)
