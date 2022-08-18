/**
 * @infor Front page entry
 * @path  ./js/index.js
 */

$(document).ready( _ => {

	//get address bar parameters
	$('#username').html(getQueryString('username'));
	//determine whether to log in
	if(!$('#username').html())
		window.location.href = '/login';

	// initialize chess
	let cChess = new ChinaChess()

	//set up waiting to play chess
	wait();
})

/**
 * waiting
 * @return void
 */
function wait () {
	setInterval( _ => {
		var val = $('.currentTeam>i').html();
		switch (val) {
			case '.':
				$('.currentTeam>i').html('..');
				break;
			case '..':
				$('.currentTeam>i').html('...');
				break;
			case '...':
				$('.currentTeam>i').html('.');
				break;
		}
	}, 500); //0.5s change
}