# Platform for Experimental, Collaborative Ethnography (PECE)

PECE is a Free and Open Source (Drupal-based) digital platform that supports
multi-sited, cross-scale ethnographic and historical research. PECE is built
as a [Drupal distribution](https://www.drupal.org/documentation/build/distributions)
to be improved and extended like any other Drupal project.

This repository contains the **development code** for PECE. It has work in progress which
is intended to be used by developers to suggest bug fixes and improvements,
as well as a starting point for customizations of the platform. If you are a
developer wishing to contribute to the development process, this is the
repository you must use.

If you are an end-user looking for stable PECE releases, please access the repository
[PECE-distro](https://github.com/PECE-project/pece-distro), which contains our
installation package with the latest stable version. If you have general questions about
the platform, please refer to our [complete documentation](http://pece.readthedocs.io/en/latest/).

## Prerequisites

PECE development is made easy by using the following software projects:

  * [Docker](https://docs.docker.com/get-docker/)
  * [Docker Compose](https://docs.docker.com/compose/)

Keep in mind that these are prerequisites for the *development environment* of
the PECE project, not for the end-user software. In other words, you will
not need to follow these instructions if you are only interested in installing
and running PECE. Please, refer to our [official
documentation](http://pece.readthedocs.io/en/latest/installation.html) if you are
looking for instructions for regular PECE installation and usage.

## Getting Started

If you follow these instructions you will get a copy of the project up and running on your local machine for development and testing purposes. Proceed to the **Deployment** to learn how to deploy the project on a live system.

### Download

To download the project, simply clone it to your directory of choice as follows:

```sh
git clone git://github.com/PECE-project/p2-dev.git
cd p2-dev
```

### Installing dependencies

PECE dependends on a bunch of packages and libraries, which will mostly help building PECE. To install all of these dependencies you can run the following command:

```sh
make install
```

### Build

Toolkit - the tool behind PECE building system. Toolkit provides many commands through the its own interface. We encapsulate some of them inside 'Make tasks' with the intend to ease the building and configuration steps.

#### 1. Download Drupal and contributed modules to build the distro:

```sh
make build
```

#### 1. Setup the development workspace:

```sh
make build-dev
```

At this point you can access the application in the following url: [http://localhost:8080](http://localhost:8080)

#### 3. Configure the host name

Now you should have the directory *web* already created as Drupal's root. You should go forward and configure internal host name mapping in /etc/hosts file to use a custom local domain URL rather than localhost. 

```sh
127.0.0.1  pece.local
```

#### 4. Setup permissions

Drupal requires you give permission for the HTTP server user to write to the files directory. This is a crucial step in order to continue the installation process. Pre and post-configuration steps must be taken in order to ensure that proper permissions are set. Please refer to the [official Drupal documention on how to properly setup the permissions](https://www.drupal.org/documentation/install/settings-file) in your server backend. 

#### 5. Installing Drupal

There are currently two methods for installing a new PECE instance: via command-line or using the web browser.

##### 5.1 Using the browser

In your browser, access the url `/web/core/install.php`, preceded with the domain serving the site. The install process is self-explanatory. Keep in mind it takes a while to finish (up to 30 minutes on low-end configuration servers).

##### 5.2 Using the command-line

There is a one-command install available through Make. Keep in mind that this command will erase any currently available data on the database configured on step 1. To proceed, run the following:

```sh
make site-install
```

> If the user running the Make task differs from the user which is being used by the web server, you will need to redo step 4 in other to make sure the server has proper permission to manage files.


#### 6. (Optional) Adding demo content

PECE comes with a script to add some testing content. To execute it, run:

```sh
make demo
```

Alternatively, you can do it in your browser by accessing Configuration > Development > PECE Demo (or `/admin/config/development/pece/demo`). This route will only be available if you configured the environment to *development* or if you enabled `pece_demo` module.

## Running the tests

### Requirements
- User: admin
- Passwords: `123456789`

It's necessary has an image with the name sf.jpg in the library to use in uploads fields.

```sh 
npm run cypress:open
```
Click on the test you want to run.

TODO

## Deployment

TODO

## Contributing

Contributions should be done [using pull requests](https://help.github.com/articles/using-pull-requests) to this repository. We keep the `master` branch current with tested, stable code. The branch `dev` is used for the on-going development tasks, new features, and bug fixes.

Our [Contributors' guide](http://pece.readthedocs.io/en/latest/contributors.html) contains all the information you will need to know about the project before submitting your contribution. Please read it before sending us pull requests.

## Authors

Our official documentation contains the information on authorship for the design and implementation tasks of the platform. Please check the document [PECE Team](http://pece.readthedocs.io/en/latest/team.html) for more information.

## License

All the code produced for PECE is released under the GNU GPL version 3 only. Please, read our [legal documents for more information](http://pece-project.github.io/drupal-pece/legal/).