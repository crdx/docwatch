async function run() {
    try {
        await fetch('/wait')
        document.location.reload()
    } catch (e) {
        setTimeout(run, 1000)
    }
}

run()
