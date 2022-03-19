# Contributing

## What is this?

The `docs-refresh` branch of `xubuntu-docs` is our development branch for the new and improved user documentation. Xubuntu's documentation is written in an XML format known as [DocBook](https://docbook.org/). DocBook allows us to write the documentation once and distribute as HTML and PDF. While it is admittedly difficult to write and format, the benefits outweigh the difficulty. To make the documentation easier to write and collaborate on, we drafted the updates in [Google Drive](https://drive.google.com/drive/folders/10nsLPokttFjG9g4x4mLBYNkTyO0izy5H). Now we need your help to move the documentation back into valid DocBook format.

On every push to the `docs-refresh` branch, the HTML documentation will be built and automatically deployed to [xubuntu.github.io/xubuntu-docs](https://xubuntu.github.io/xubuntu-docs/).

## Getting Started

1. Fork xubuntu-docs to your own repository.
2. Checkout the `docs-refresh` branch:
```
git checkout docs-refresh
```
3. Make your changes and commit.
4. Submit a pull request with your changes. The pull request should be against the `docs-refresh` branch.
5. Make adjustments as needed until the tests pass. Pull requests with failing tests will not be considered. Please see the _Running Tests_ section below for instructions on running the tests on your own machine.
6. Mark updated files as completed in this file.

## Notes
- Please see [Google Drive](https://drive.google.com/drive/folders/10nsLPokttFjG9g4x4mLBYNkTyO0izy5H) for the documents to convert. Updated and newly added files will be found in the `user-docs/C` directory.
- Mark files complete once all content and images are included and GitHub actions run successfully.
- Make sure you're starting from the right branch!

## Google Drive
- [x] ~[0. Homepage](https://docs.google.com/document/d/1Aj_Wdj9Uq62Ju0bvjhz15NVdaI_SaAMo8xqdU9s67YE/edit?usp=sharing) (0%, `startpage/index.html`)~
- [x] [1. Welcome](https://docs.google.com/document/d/1KpmN_tCOHaDwQgNtqyyt6DqZ7M0xSMCNTadORcY_Whw/edit?usp=sharing) (100%, `user-docs/C/index.xml`)
- [x] [2. Credits and License](https://docs.google.com/document/d/17v09cwXQLc-xs06inNz0KnEgllleUaJDPg4kV0dHF9Q/edit?usp=sharing) (100%, `user-docs/C/index.xml`)
- [x] [3. Appendix B - Creative Commons](https://docs.google.com/document/d/1zkAFZHw1d3OOgx3C2Bxjr4VduVKho423k0fnCWLc6XI/edit?usp=sharing) (100%, `libs-common/cc-by-sa.xml`)
- [x] [Chapter 1. What is Xubuntu?](https://docs.google.com/document/d/1kkq51aJLT-BdCogUS4INhrR4e_IRgLT7YlUAWL32m4g/edit?usp=sharing) (100%, `user-docs/C/what-is-xubuntu.xml`)
- [x] [Chapter 2. Installation](https://docs.google.com/document/d/1EWQkW0aP6pk0LrSVlwFk8F2SIJietHNzX9g2Z34fbhE/edit?usp=sharing) (100%, `user-docs/C/installation.xml`)
- [x] [Chapter 3. Introduction](https://docs.google.com/document/d/1wlzxgu3yUiLnUd5zoU0MgpI4x1spOo9N1F1wuuzVdl0/edit?usp=sharing) (100%, `user-docs/C/introduction.xml`)
- [x] [Chapter 4. Default Applications](https://docs.google.com/document/d/1igFIwL0kRnxu3aAUC-yJeGJfDK1LVKYx24u6NXtw2gs/edit?usp=sharing) (100%, `user-docs/C/guide-default-apps.xml`)
- [x] [Chapter 5. Software Management](https://docs.google.com/document/d/1baVr_9CUEHd2c8y0_W0INc20c8LAKS8PNJknJnS8NpM/edit?usp=sharing) (100%, `user-docs/C/software-management.xml`)
- [x] [Chapter 6. Settings - Personalization](https://docs.google.com/document/d/1WC4y48PRXpjSUo8dAZHSgmN4BvnKK4LBkrjPWJDz848/edit?usp=sharing) (100%, `user-docs/C/settings-personalization.xml`)
- [x] [Chapter 7. Settings - Hardware](https://docs.google.com/document/d/17ns9RcfTP98F2tD1X8sWF3bbOteQ0b4zUTstD0Ux8Lo/edit?usp=sharing) (100%, `user-docs/C/settings-hardware.xml`)
- [x] [Chapter 8. Settings - Connectivity](https://docs.google.com/document/d/1XbPCwmv3r1R_HdJ99ORqgqY-2f8dhpaUrpGYOH_-gsU/edit?usp=sharing) (100%, `user-docs/C/settings-connectivity.xml`)
- [x] [Chapter 9. Printing and Scanning](https://docs.google.com/document/d/1Tkei3fxi3UtpsY2QE5ubBv46s8Q3im3PjLTy-pwx6-I/edit?usp=sharing) (100%, `user-docs/C/printing-scanning.xml`)
- [x] [Chapter 10. User Management](https://docs.google.com/document/d/1zySTkXoxPJPvVR7DpTwCCmSZ8k0izkAPUyzh1cbDBUw/edit?usp=sharing) (100%, `user-docs/C/user-management.xml`)
- [x] ~[Chapter 11. Disks](https://docs.google.com/document/d/1J0JmtGaCmNJJzGmIdDu2eYWkoyXHQkoaKG7ThJovp7s/edit?usp=sharing) (Incomplete, 0%)~
- [x] [Chapter 12. File Management](https://docs.google.com/document/d/1qY7MJDguvPCzV-BMa9P9ZFSEPneq4nZ6AhgN-Zz5UNA/edit?usp=sharing) (100%, `user-docs/C/file-management.xml`)
- [x] ~[Chapter 13. Laptops](https://docs.google.com/document/d/1XWe8GApyy3Y-GahLEp9VKJV0Ahf9LXf10YuNNpxEmYk/edit?usp=sharing) (Incomplete, 0%)~
- [x] [Chapter 14. Media Applications](https://docs.google.com/document/d/11AEaV1uqNoZCAb7elvMMl-uMt_5_wAtsfORhkLj0nmw/edit?usp=sharing) (100%, `user-docs/C/media-apps.xml`)
- [x] [Chapter 15. Migrating](https://docs.google.com/document/d/1SifZ1BDchAOatt43zh8mjwV285ucuKwdfEfWXKZQgPc/edit?usp=sharing) (100%, `user-docs/C/migrating.xml`)
- [x] [Chapter 16. Troubleshooting](https://docs.google.com/document/d/1KsbAaCqHHpb9Yl4lx9vZAtgYYATXgblMfAO_9I5_j8Q/edit?usp=sharing) (100%, `user-docs/C/troubleshooting.xml`)
- [x] [Chapter 17. Upgrading](https://docs.google.com/document/d/1hR7tcqXLHZoXv8znGG05ioiFPRrAO6kAtyyeFkYcuoc/edit?usp=sharing) (100%, `user-docs/C/upgrading.xml`)

## Running Tests
On each commit, GitHub will run a series of tests as found in [test-translations.yml](https://github.com/Xubuntu/xubuntu-docs/blob/docs-refresh/.github/workflows/test-translations.yml). If you want to run these tests yourself without committing (please do), do the following.

### Install requirements (only required once)
```
sudo apt install ubuntu-dev-tools default-jre docbook-xml docbook-xsl fonts-dejavu-core fonts-noto fop itstool libxml2-utils xsltproc
```

### Run the tests
```
make clean && \
make user-get-translations && \
make contributor-get-translations TRANSPERC=20 && \
make user-html && \
make user-html-translations && \
make contributor-html && \
make contributor-html-translations TRANSPERC=20 && \
make startpage REVNO=${GITHUB_SHA} && \
make test && \
echo "Tests successful"
```
