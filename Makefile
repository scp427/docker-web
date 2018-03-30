workspace = <this directory absolute dir>
projectspace = <your project workdir>

build-nginx:
	docker build -t scp427/web-nginx build/nginx

build-fpm:
	docker build -t scp427/web-fpm build/php

run-nginx:
	docker run -i -d -p 8080:8080 -v $(workspace)/nginx/etc/nginx.conf:/etc/nginx/nginx.conf -v $(workspace)/nginx/etc/fastcgi_params:/etc/nginx/fastcgi_params -v $(workspace)/nginx/etc/sites-enabled:/etc/nginx/sites-enabled -v $(workspace)/nginx/log:/var/log/nginx -v $(workspace)/	-v $(projectspace)/www:/www --link web-fpm:web-fpm --volumes-from web-fpm --name web-nginx -t scp427/web-nginx
	
run-fpm:
	docker run -i -d -v $(workspace)/php/etc/php.ini:/etc/php/7.0/fpm/php.ini -v $(workspace)/php/etc/php-fpm.conf:/etc/php/7.0/fpm/php-fpm.conf -v $(workspace)/php/etc/pool.d:/etc/php/7.0/fpm/pool.d -v $(workspace)/php/log:/var/log -v $(projectspace)/www:/www --name web-fpm scp427/web-fpm
	