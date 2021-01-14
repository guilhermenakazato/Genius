function bemVindo() {
    const button = document.querySelectorAll("button");

    //Treco escreveno
    var h2 = document.querySelector("h2");
    var typewriter = new Typewriter(h2, {
        loop: false,
        delay: 20,
    })

    typewriter.typeString("Olá! Essa é a página da documentação do Genius.")
        .pauseFor(500)
        .typeString("<br/>O que deseja fazer?")
        .pauseFor(1000)
        .start();

    typewriter.changeCursor(" ");

    // Fade dos botões
    setTimeout(() => {
        button.forEach((el) => {
            el.classList.toggle("mostrar")
        })
    }, 4000);
}

function sobre() {
    var h2 = document.querySelector("h2#sobre-title");
    var p = document.querySelector("p#sobre");

    var typewriterh = new Typewriter(h2, {
        loop: false,
        delay: 20,
    })
    typewriterh.typeString("Sobre o Genius").pauseFor(1000).start();
    typewriterh.changeCursor(" ")

    setTimeout(() => {
        var typewriter = new Typewriter(p, {
            loop: false,
            delay: 20,
        })

        typewriter.typeString("O projeto Genius consiste na criação de um aplicativo "
            + "com o auxílio do framework Flutter, desenvolvido pela Google, sendo construído "
            + "por dois estudantes do Instituto Federal de Educação, Ciência e Tecnologia de Mato Grosso do Sul, "
            + "Gabriela Prado e Guilherme Nakazato, orientados pelo professor Sidney Sousa. Esse aplicativo tem como objetivo levar a Ciência nacional "
            + "para todos os brasileiros. Sendo assim, essa página foi criada para ajudar no entendimento dos códigos "
            + "construídos durante a produção do Genius.").pauseFor(1000).start()

        typewriter.changeCursor(" ");
    }, 1200);
}