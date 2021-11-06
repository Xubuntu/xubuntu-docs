# Contributing

Please see [Google Drive](https://drive.google.com/drive/folders/10nsLPokttFjG9g4x4mLBYNkTyO0izy5H) for the documents to convert. Updated and newly added files will be found in the `user-docs/C` directory.

Mark files complete once all content and images are included and GitHub actions run successfully.

## Google Drive
- [ ] [0. Homepage](https://docs.google.com/document/d/1Aj_Wdj9Uq62Ju0bvjhz15NVdaI_SaAMo8xqdU9s67YE/edit?usp=sharing) (0%, `startpage/index.html`)
- [ ] [1. Welcome](https://docs.google.com/document/d/1KpmN_tCOHaDwQgNtqyyt6DqZ7M0xSMCNTadORcY_Whw/edit?usp=sharing) (90%, `user-docs/C/index.xml`, image placeholders)
- [ ] [2. Credits and License](https://docs.google.com/document/d/17v09cwXQLc-xs06inNz0KnEgllleUaJDPg4kV0dHF9Q/edit?usp=sharing) (0%)
- [ ] [3. Appendix B - Creative Commons](https://docs.google.com/document/d/1zkAFZHw1d3OOgx3C2Bxjr4VduVKho423k0fnCWLc6XI/edit?usp=sharing) (0%)
- [ ] [Chapter 1. What is Xubuntu?](https://docs.google.com/document/d/1kkq51aJLT-BdCogUS4INhrR4e_IRgLT7YlUAWL32m4g/edit?usp=sharing) (90%, `user-docs/C/what-is-xubuntu.xml`, correct image alignment, fix image transparency)
- [ ] [Chapter 2. Installation](https://docs.google.com/document/d/1EWQkW0aP6pk0LrSVlwFk8F2SIJietHNzX9g2Z34fbhE/edit?usp=sharing) (90%, `user-docs/C/installation.xml`, image placeholders)
- [ ] [Chapter 3. Introduction](https://docs.google.com/document/d/1wlzxgu3yUiLnUd5zoU0MgpI4x1spOo9N1F1wuuzVdl0/edit?usp=sharing) (0%, `user-docs/C/introduction.xml`)
- [ ] [Chapter 4. Default Applications](https://docs.google.com/document/d/1igFIwL0kRnxu3aAUC-yJeGJfDK1LVKYx24u6NXtw2gs/edit?usp=sharing) (90%, `user-docs/C/guide-default-apps.xml`, image placeholders and layout)
- [ ] [Chapter 5. Software Management](https://docs.google.com/document/d/1baVr_9CUEHd2c8y0_W0INc20c8LAKS8PNJknJnS8NpM/edit?usp=sharing) (90%, `user-docs/C/software-management.xml`, image placeholders)
- [ ] [Chapter 6. Settings - Personalization](https://docs.google.com/document/d/1WC4y48PRXpjSUo8dAZHSgmN4BvnKK4LBkrjPWJDz848/edit?usp=sharing) (0%)
- [ ] [Chapter 7. Settings - Hardware](https://docs.google.com/document/d/17ns9RcfTP98F2tD1X8sWF3bbOteQ0b4zUTstD0Ux8Lo/edit?usp=sharing) (0%)
- [ ] [Chapter 8. Settings - Connectivity](https://docs.google.com/document/d/1XbPCwmv3r1R_HdJ99ORqgqY-2f8dhpaUrpGYOH_-gsU/edit?usp=sharing) (0%)
- [ ] [Chapter 9. Print and Scan](https://docs.google.com/document/d/1Tkei3fxi3UtpsY2QE5ubBv46s8Q3im3PjLTy-pwx6-I/edit?usp=sharing) (0%)
- [ ] [Chapter 13. Administrative Tasks](https://docs.google.com/document/d/1zySTkXoxPJPvVR7DpTwCCmSZ8k0izkAPUyzh1cbDBUw/edit?usp=sharing) (0%, `user-docs/C/administrative-tasks.xml`)
- [ ] [Chapter X. Disks](https://docs.google.com/document/d/1J0JmtGaCmNJJzGmIdDu2eYWkoyXHQkoaKG7ThJovp7s/edit?usp=sharing) (0%)
- [ ] [Chapter X. File Management](https://docs.google.com/document/d/1qY7MJDguvPCzV-BMa9P9ZFSEPneq4nZ6AhgN-Zz5UNA/edit?usp=sharing) (0%)
- [ ] [Chapter X. Laptops](https://docs.google.com/document/d/1XWe8GApyy3Y-GahLEp9VKJV0Ahf9LXf10YuNNpxEmYk/edit?usp=sharing) (0%)
- [ ] [Chapter X. Media Applications](https://docs.google.com/document/d/11AEaV1uqNoZCAb7elvMMl-uMt_5_wAtsfORhkLj0nmw/edit?usp=sharing) (0%)
- [ ] [Chapter X. Migrating](https://docs.google.com/document/d/1SifZ1BDchAOatt43zh8mjwV285ucuKwdfEfWXKZQgPc/edit?usp=sharing) (0%)
- [ ] [Chapter X. Troubleshooting](https://docs.google.com/document/d/1KsbAaCqHHpb9Yl4lx9vZAtgYYATXgblMfAO_9I5_j8Q/edit?usp=sharing) (0%)
- [ ] [Chapter X. Upgrading](https://docs.google.com/document/d/1hR7tcqXLHZoXv8znGG05ioiFPRrAO6kAtyyeFkYcuoc/edit?usp=sharing) (0%)

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
