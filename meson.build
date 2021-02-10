project('com.github.devhammed.todoer', 'vala', 'c', version: '1.0.0')

executable(
  meson.project_name(),
  'src/todoer.vala',
  import('gnome').compile_resources(
    '@0@.resources'.format(meson.project_name()),
    'data/@0@.gresource.xml'.format(meson.project_name()),
    source_dir: 'data',
  ),
  dependencies: [
    dependency('gtk+-3.0'),
    dependency('gmodule-2.0')
  ],
  install : true
)
