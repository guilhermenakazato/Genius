# 💡 Genius
O Genius é o resultado esperado de um projeto (TCC) a ser apresentado no final do curso Técnico Integrado de Informática, do Instituto Federal de Educação, Ciência e Tecnologia de Mato Grosso do Sul, Campus Aquidauana, tendo o objetivo de divulgar toda a ciência brasileira de uma forma acessível.

# 👋 Tabela de conteúdos 
* [Pré-requisitos](#pré-requisitos)
* [Tecnologias utilizadas](#tecnologias-utilizadas) 
* [Instalação](#instalação)
    * [Backend](#backend)
    * [Frontend](#frontend)
* [Licença](#licença)

# ✔️ Pré-requisitos
👉 [NodeJS >= 12.0.0 e npm >= 6.0.0](https://nodejs.org/en/)<br />
👉 [Flutter (SDK) e Android SDK](https://flutter.dev/docs/get-started/install)

# 🛠️ Tecnologias utilizadas
👉 [AdonisJS](https://preview.adonisjs.com)<br />
👉 [Flutter](https://flutter.dev)

# 💻 Instalação
Para a instalação e utilização do Genius no seu próprio dispositivo, faça um clone do repositório e entre nele. 
```
git clone https://github.com/guilhermenakazato/Genius.git
cd Genius
```
# ⚙️ Backend 
Após isso, será necessário instalar as dependências do backend. 
```
cd backend
npm i
```
Terminada a instalação das dependências, é necessário rodar o backend para que o frontend consiga utilizar dos dados disponíveis. 
```
node ace serve --watch
```

# 📱 Frontend
Com o backend rodando, será necessário apenas rodar o aplicativo no seu dispositivo móvel. Note que o mesmo deve estar previamente configurado.
```
flutter run
```
ou, caso queira uma versão com mais performance,  
```
flutter run --release
```

Feito isso, o aplicativo estará totalmente disponível para uso no seu dispositivo móvel.

# 📄 Licença 
Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](./LICENSE) para mais informações sobre ela.