function easteregg() {
if(window.console || "console" in window) {
	console.log(`%c
     ____.               __                      _________      .__                            
    |    |__ __  _______/  |_ __ __  ______     /   _____/ ____ |__| ____   ____   ____  ____  
    |    |  |  \\/  ___/\\   __\\  |  \\/  ___/     \\_____  \\_/ ___\\|  |/ __ \\ /    \\_/ ___\\/ __ \\ 
/\\__|    |  |  /\\___ \\  |  | |  |  /\\___ \\      /        \\  \\___|  \\  ___/|   |  \\  \\__\\  ___/ 
\\________|____//____  > |__| |____//____  > /\\ /_______  /\\___  >__|\\___  >___|  /\\___  >___  >
                    \\/                  \\/  \\/         \\/     \\/        \\/     \\/     \\/    \\/ `, "color:#3A8DE5; font-family:monospace");
	console.log(`%c Welcome to my site`, "color:#FFA13C; font-size:16px; font-family:monospace; font-weight: bold");
	console.log(`%c I like your enthusiasm but here you won't find any content here`, "color:#194D90; font-size:12px; font-family:monospace");
	console.log(`%c If you are interested in the source-code go to github.com/JustusAdam/justusadam.github.io`, "color:#194D90; font-size:12px; font-family:monospace");
}
}
window.onload = easteregg;