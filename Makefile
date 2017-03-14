
test:
	docker run -it --rm -v $(CURDIR):/usr/src/myapp -w /usr/src/myapp ruby:2.4 bundle install && bundle exec rake