function checkForLinkType(value){
	if (value == 'internal_link') {
		$('#internal_link_field').show();
		$('#external_link_field').hide();
	}
	else {
		$('#external_link_field').show();
		$('#internal_link_field').hide();
	}
}
