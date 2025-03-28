FROM postgres:latest

# Copy extracted PostgreSQL extension files
COPY --chown=postgres:postgres .docker/lib/postgresql/ /usr/lib/postgresql/
COPY --chown=postgres:postgres .docker/share/postgresql/ /usr/share/postgresql/

# Ensure permissions are correct
USER root
RUN chmod -R 755 /usr/lib/postgresql/ /usr/share/postgresql/
USER postgres

# Run PostgreSQL
CMD ["postgres"]