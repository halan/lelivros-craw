# Crawler for Download Lelivro.red books

## Usage

### Download all (mobi)
```
./crawler
```

or
```
bundle exec rake
```

### Download all (epub)
```
bundle exec rake default[epub]
```

### Download just one category (mobi)
```
bundle exec rake category[http://lelivros.red/categoria/filosofia/,Filosofia]
```

### Download just one category (epub)
```
bundle exec rake category[http://lelivros.red/categoria/filosofia/,Filosofia,epub]
```
