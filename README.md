# Base docker image for Odoo OpenUpgrade
Basically this image is base image which prepares running environment for Odoo OpenUpgrade to migrate odoo 10 to odoo 11.

# Usage
To use this image, just use create another image by extending from this image. The migration scripts from OpenUpgrade should be copied to the root directory and additional addons should be copied to /more-addons directory. e.g.

    COPY ./ /
    COPY ./my-addons /more-addons

## Running
After building the new image, use the "migrate" command to migrate data.

## Environment Variables
* HOST - Database Host (default value : db)
* PORT - Database Port (default value : 5432)
* USER - Database User (default value : odoo)
* PASSWORD - Database Password (default value : odoo)
