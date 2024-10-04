# Start from a light-weight ruby image
FROM ruby:3.3.4-alpine

# Install gcc, make and git
RUN apk add build-base git

# Update config
ENV GEM_HOME=$HOME/gems PATH=$HOME/gems/bin:$PATH

# Make directory for site
WORKDIR /site

# The Jekyll server runs on port 4000 by default
EXPOSE 4000

# Install jekyll and the required gems for the site
COPY script/bootstrap /usr/local/bin
COPY Gemfile Gemfile.lock jekyll-theme-cayman.gemspec /site/
RUN bootstrap

# Run jekyll-serve for dynamic development
CMD [ "bundle", "exec", "jekyll", "serve", "--livereload", "--force_polling", "-H", "0.0.0.0", "-P", "4000"]