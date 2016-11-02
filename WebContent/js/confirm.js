function conf(url,obj){
	
	if(confirm("Remover " + obj + "?")){		
		location.href = url;		
	}else{
		return false
	}
}