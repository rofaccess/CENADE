# Crea la imagen en base a una imagen pre-existente
FROM ruby:2.2.4

# Indica cual es el directorio de trabajo dentro del contenedor
WORKDIR /code

# Copia primero estos archivos antes de copiar tódo el proyecto
# Esto es necesario para que se pueda usar el volumen gem_cache definido en compose.yaml y así evitar
# reinstalar las gemas luego de borrar la imagen y reconstruirla.
COPY Gemfile Gemfile.lock ./

# Verifica si las gemas ya están instaladas osino las instala
RUN bundle check || bundle install

# Copia el directorio actual del host dentro del directorio de trabajo del contenedor
COPY . .

# Crea un usuario y grupo, ambos llamados rails. Al especificar el uid y gid 1000, se pueden crear
# archivos dentro del contenedor y serán modificables por el usuario del host, ya que usualmente tiene
# el mismo uid y gid. También se actualizan los permisos del Gemfile.lock y otras carpetas para que puedan
# ser modificadas desde el contenedor con el nuevo usuario.
RUN groupadd --system --gid 1000 rails && \
    useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash && \
    chown -R rails:rails Gemfile.lock db #log tmp \

USER 1000:1000

# Ejecuta la aplicación al levantar el contendedor
# Es necesario indicar -b 0.0.0.0 para que la aplicación escuche en todas las interfaces, esto debe hacerse a partir de Rails 4.x
CMD ["rails", "s", "-b", "0.0.0.0"]
