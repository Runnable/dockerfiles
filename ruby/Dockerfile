FROM runnable/base:1.0.0

# Install desired ruby version
RUN rbenv install 2.2.2
RUN rbenv global 2.2.2
RUN /bin/bash -l -c "gem install bundler"

# Open up ports on the server
EXPOSE 3000

# Command to start the app
CMD ruby --version
