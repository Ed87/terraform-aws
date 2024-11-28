<a name="readme-top"></a>

<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]




<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/othneildrew/Best-README-Template">
    <img src="images/logo.png" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">From Terraform to Terragrunt</h3>

  <p align="center">
    An awesome README template to jumpstart your projects!
    <br />
    <a href="https://github.com/othneildrew/Best-README-Template"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/othneildrew/Best-README-Template">View Demo</a>
    ·
    <a href="https://github.com/othneildrew/Best-README-Template/issues">Report Bug</a>
    ·
    <a href="https://github.com/othneildrew/Best-README-Template/issues">Request Feature</a>
  </p>
</div>



<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

[![Product Name Screen Shot][product-screenshot]](https://example.com)

This project is a reference implementation of migrating from a vanilla Terraform project to a full-fledged Terragrunt managed project.

The following aspects are included:
* Clean Code
* Unit Tests
* Static Application Security Testing
* Semantic Versioning
* Git
* Secrets Management
* Configuration-as-Code
* Infrastructure-as-Code
* Release Management


Use the `BLANK_README.md` to get started.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



### Built With

This section should list any major frameworks/libraries used to bootstrap your project. Leave any add-ons/plugins for the acknowledgements section. Here are a few examples.


* [![Terraform][React.js]][React-url]
* [![Terragrunt][FastAPI.io]][FastAPI-url]



<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- GETTING STARTED -->
## Getting Started

This is an example of how you may give instructions on setting up your project locally.
To get a local copy up and running follow these simple example steps.

### Prerequisites

This is an example of how to list things you need to use the software and how to install them.
* npm
  ```sh
  npm install npm@latest -g
  ```

### Refactor to Terragrunt

_Below is a set of steps for refactoring the project to a Terragrunt structure._

## Level One Changes: Environments and Regions
1. Existing directory structure is:
/.terraform
/docs
/iam
/networking
/storage
/.gitignore
/.README
/.terraform.lock.hcl

Under each module directory exists at least one of the files main.tf, locals.tf, variable.tf, outputs.tf e.g for networking:
/networking/
    main.tf
    variables.tf
    outputs.tf
    locals.tf

2. Add the environments directory and the following structure:
 ```sh
   /environments/dev
   /environments/prod
```

3. In the enviroments directory add the AWS regions you want deploy to:
   ```sh
   /environments/dev/eu-north-1
   /environments/dev/eu-cent
 ```

    ```sh
   /environments/prod/eu-north-1
   /environments/prod/eu-central-1
   ```
4. Add the modules directory and the following structure:
   ```sh
   /modules/iam
   /modules/networking
   /modules/storage
   ```
5. New top level directory structure will be:
/.terraform
/docs
/environments
/modules
/.gitignore
/.README
/.terraform.lock.hcl


## Level Two Changes: Modules
1. Create subdirectories in the modules directory as below:
```sh
  /modules/iam
  /modules/networking
  /modules/storage
   ```
2. Move all files in the existing module directories to their respective subdirectories in (1) e.g for networking:
move the files:

  ```sh
  /networking/
    main.tf
    variables.tf
    outputs.tf
    locals.tf
   ```

 to:

 ```sh
  /modules/networking/
    main.tf
    variables.tf
    outputs.tf
    locals.tf
   ```
3. Delete all module directories that exist at project root i.e:
 ```sh
/iam
/networking
/storage
```


## Level Three Changes: Root module config files
1. Move the following files at the project root to their each existing (AWS) region directory e.g for eu-north-1:
move the files:

  ```sh
  /
    main.tf
    variables.tf
    outputs.tf
    locals.tf
    providers.tf
    backend.tf
   ```

 to:

 ```sh
  /environments/dev/eu-north-1/
    main.tf
    variables.tf
    outputs.tf
    locals.tf
    providers.tf
    backend.tf
   ```

2. Delete the following files that remain at the project root:
 ```sh
/.terraform.lock.hcl
/.terraform
```

## Level Four Changes: Multi-Environment setup
1. Delete the existing remote state S3 bucket in AWS console
2. Delete backend.tf from each region directory e.g for eu-north-1
from:

  ```sh
  /
    main.tf
    variables.tf
    outputs.tf
    locals.tf
    providers.tf
    backend.tf
   ```

 to:

 ```sh
  /environments/dev/eu-north-1/
    main.tf
    variables.tf
    outputs.tf
    locals.tf
    providers.tf
   ```
3. Execute terraform init to reinitialize the terraform project.
4. Create a new S3 bucket and copy the bucket name.
5. To each AWS region folder, reintroduce backend.tf file for remote state backend. Update the key under the existing bucket name from (2), e.g for eu-north-1:

```sh
terraform {
    backend "s3" {
      bucket  = "tfstate-bucket-xxxxx"
      key     = "dev/eu-north-1/remote.tfstate"
      region  = "eu-north-1"
      encrypt = true
    }
  }
 ```

<!-- USAGE EXAMPLES -->
## Usage

Use this space to show useful examples of how a project can be used. Additional screenshots, code examples and demos work well in this space. You may also link to more resources.

_For more examples, please refer to the [Documentation](https://example.com)_

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- ROADMAP -->
## Roadmap

- [x] Add Changelog
- [x] Add back to top links
- [ ] Add Additional Templates w/ Examples
- [ ] Add "components" document to easily copy & paste sections of the readme
- [ ] Multi-language Support
    - [ ] Chinese
    - [ ] Spanish

See the [open issues](https://github.com/othneildrew/Best-README-Template/issues) for a full list of proposed features (and known issues).

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE.txt` for more information.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- CONTACT -->
## Contact

Your Name - [@your_twitter](https://twitter.com/your_username) - email@example.com

Project Link: [https://github.com/your_username/repo_name](https://github.com/your_username/repo_name)

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- ACKNOWLEDGMENTS -->
## Acknowledgments

Use this space to list resources you find helpful and would like to give credit to. I've included a few of my favorites to kick things off!

* [Choose an Open Source License](https://choosealicense.com)
* [GitHub Emoji Cheat Sheet](https://www.webpagefx.com/tools/emoji-cheat-sheet)
* [Malven's Flexbox Cheatsheet](https://flexbox.malven.co/)
* [Malven's Grid Cheatsheet](https://grid.malven.co/)
* [Img Shields](https://shields.io)
* [GitHub Pages](https://pages.github.com)
* [Font Awesome](https://fontawesome.com)
* [React Icons](https://react-icons.github.io/react-icons/search)

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/othneildrew/Best-README-Template.svg?style=for-the-badge
[contributors-url]: https://github.com/othneildrew/Best-README-Template/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/othneildrew/Best-README-Template.svg?style=for-the-badge
[forks-url]: https://github.com/othneildrew/Best-README-Template/network/members
[stars-shield]: https://img.shields.io/github/stars/othneildrew/Best-README-Template.svg?style=for-the-badge
[stars-url]: https://github.com/othneildrew/Best-README-Template/stargazers
[issues-shield]: https://img.shields.io/github/issues/othneildrew/Best-README-Template.svg?style=for-the-badge
[issues-url]: https://github.com/othneildrew/Best-README-Template/issues
[license-shield]: https://img.shields.io/github/license/othneildrew/Best-README-Template.svg?style=for-the-badge
[license-url]: https://github.com/othneildrew/Best-README-Template/blob/master/LICENSE.txt
[product-screenshot]: images/screenshot.png
[React.js]: https://img.shields.io/badge/React-20232A?style=for-the-badge&logo=react&logoColor=61DAFB
[React-url]: https://reactjs.org/
[Node.js]: https://img.shields.io/badge/React-20232A?style=for-the-badge&logo=react&logoColor=61DAFB
[Node-url]: https://nodejs.org/en/about/
[Spring.io]: https://img.shields.io/badge/Spring-6DB33F?style=for-the-badge&logo=spring&logoColor=white
[Spring-url]: https://spring.io/
[FastAPI.io]: https://img.shields.io/badge/FastAPI-14354C?style=for-the-badge&logo=python&logoColor=white
[FastAPI-url]: https://fastapi.tiangolo.com/
[Node.js]: https://img.shields.io/badge/Node.js-43853D?style=for-the-badge&logo=node.js&logoColor=white
[Node-url]: https://expressjs.com/
[Bootstrap.com]: https://img.shields.io/badge/Bootstrap-563D7C?style=for-the-badge&logo=bootstrap&logoColor=white
[Bootstrap-url]: https://getbootstrap.com
[Dotnet.io]: https://img.shields.io/badge/.NET-5C2D91?style=for-the-badge&logo=.net&logoColor=white
[Dotnet-url]: https://dotnet.microsoft.com/en-us/download