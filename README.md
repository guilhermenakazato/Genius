# :bulb: Genius
O Genius é o resultado esperado de um projeto (TCC) a ser apresentado no final do curso Técnico Integrado de Informática, do Instituto Federal de Educação, Ciência e Tecnologia de Mato Grosso do Sul, Campus Aquidauana, tendo o objetivo de divulgar toda a ciência brasileira de uma forma acessível.

# :wave: Tabela de conteúdos 
* [Pré-requisitos]()
* [Tecnologias utilizadas]() 
* [Instalação]()
    * [Backend]()
    * [Frontend]()
* [Licença]()

# :heavy_check_mark: Pré-requisitos
:point_right: [NodeJS >= 12.0.0 e npm >= 6.0.0](https://nodejs.org/en/)
:point_right: [Flutter (SDK) e Android SDK](https://flutter.dev/docs/get-started/install)

# :hammer_and_wrench: Tecnologias utilizadas
:point_right: [AdonisJS](https://preview.adonisjs.com) 
:point_right: [Flutter](https://flutter.dev)

# :computer: Instalação
Para a instalação e utilização do Genius no seu próprio dispositivo, faça um clone do repositório e entre nele. 
```
git clone https://github.com/guilhermenakazato/Genius.git
cd Genius
```
# :gear: Backend 
Após isso, será necessário instalar as dependências do backend. 
```
cd backend
npm i
```
Terminada a instalação das dependências, é necessário rodar o backend para que o frontend consiga utilizar dos dados disponíveis. 
```
node ace serve --watch
```

# :iphone: Frontend
Com o backend rodando, será necessário apenas rodar o aplicativo no seu dispositivo móvel. Note que o mesmo deve estar previamente configurado.
```
flutter run
```
ou, caso queira uma versão com mais performance,  
```
flutter run --release
```

Feito isso, o aplicativo estará totalmente disponível para uso no seu dispositivo móvel.

# :page_facing_up: Licença 
Este projeto está sob a licença MIT. Veja o arquivo [LICENÇA](https://github.com/guilhermenakazato/Genius/blob/master/LICENSE) para mais informações sobre ela.