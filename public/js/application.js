$(document).ready(function() {

	$('.results').on('click','#fetch',function(event){
		event.preventDefault;
		$.ajax({
			type:'GET',
			url: '/fetch_data',
			beforeSend: function(){
				$(this).addAttr('disabled','disabled');
			},
			success: function(data){
				$('.results').html(data);
			}
		});
	});

});
