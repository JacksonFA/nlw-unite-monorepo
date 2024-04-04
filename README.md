# Pass.In

O pass.in é uma aplicação de **gestão de participantes em eventos presenciais**.

## Frontend web (React)

[![React-CD](https://github.com/JacksonFA/nlw-unite-monorepo/actions/workflows/bohr.yml/badge.svg)](https://github.com/JacksonFA/nlw-unite-monorepo/actions/workflows/bohr.yml)

![Passin na web](.github/assets/web.png)

## Frontend mobile (React Native)

<div align="center" width="100%">
  <img src=".github/assets/mobile1.png" width="300" />
  <img src=".github/assets/mobile2.png" width="300" />
</div>

## Backend NodeJS (Fastify)

[![Node-CI_CD](https://github.com/JacksonFA/nlw-unite-monorepo/actions/workflows/node-ci_cd.yml/badge.svg)](https://github.com/JacksonFA/nlw-unite-monorepo/actions/workflows/node-ci_cd.yml)

Para a documentação da API em Node, acesse o link: <https://passin-node.onrender.com/docs>

## Banco de dados

Nessa aplicação vamos utilizar banco de dados relacional (SQL). Para ambiente de desenvolvimento seguiremos com o SQLite pela facilidade do ambiente.
Para ambiente "DevOps" será utilizado o PostgreSQL rodando localmente via docker-compose ou hospedado na Digital Ocean.

## DevOps

Foi configurado pipelines de CI e CD (para Render) via Github Actions e deploys automáticos para cluster kubernetes via CargoCD

![Devops ArgoCD](.github/assets/devops.jpeg)

## Requisitos

### Requisitos funcionais

- [x] O organizador deve poder cadastrar um novo evento;
- [x] O organizador deve poder visualizar dados de um evento;
- [x] O organizador deve poser visualizar a lista de participantes;
- [x] O participante deve poder se inscrever em um evento;
- [x] O participante deve poder visualizar seu crachá de inscrição;
- [x] O participante deve poder realizar check-in no evento;

### Regras de negócio

- [x] O participante só pode se inscrever em um evento uma única vez;
- [x] O participante só pode se inscrever em eventos com vagas disponíveis;
- [x] O participante só pode realizar check-in em um evento uma única vez;

### Requisitos não-funcionais

- [x] O check-in no evento será realizado através de um QRCode;
