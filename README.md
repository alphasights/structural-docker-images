# structural-docker-images
Repository with base Docker images for Structural team

See https://rolodex.alphasights.com/extras/platform-images for most recent version

## Build instruction

If you'd like to publish a new version of any image, please run following

1. Obtain AWS credentials (once per day):
  - Go to https://alphasights-eng.awsapps.com/start#/
  - Open "AWS Primary Root" -> "prod_allow_user_ecr_rw" and click on "Access keys"
  - copy shell variables (Option 1) and append them to you `~/.zshrc` file
  - run `source ~/.zshrc` or open new console tab
2. Login to Docker Registry (once per day):
  - Turn on VPN
  - run `aws ecr get-login-password` to see if it generated the password. If not, then run `aws configure`
  - run `aws ecr get-login-password | docker login -u AWS --password-stdin "https://$(aws sts get-caller-identity --query 'Account' --output text).dkr.ecr.us-east-1.amazonaws.com"`. You should get `Login Succeeded` message at the end
3. Prepare buildx to create multi-arch Docker images (only for the first time - if you already have it, you can skip it)
  - run `docker buildx create --name container --driver=docker-container`
  - in case of problems or for more details, see [this tutorial](https://medium.com/@life-is-short-so-enjoy-it/docker-how-to-build-and-push-multi-arch-docker-images-to-docker-hub-64dea4931df9), follow `Approach 2: With Using Docker BuildX`
4. Build & push image
  - Replace `<your-image-name>` with your image name (e.g. `jre-17` or `jre-21`)
  - Run `docker buildx build --platform linux/amd64,linux/arm64 --builder container --push . -t 579859358947.dkr.ecr.us-east-1.amazonaws.com/as-platform/<your-image-name>:latest -t 579859358947.dkr.ecr.us-east-1.amazonaws.com/as-platform/<your-image-name>:<pick-your-version>`
  - Build process should take around 1 minute (or more). If it is blazing fast - something is not ok and packages aren't updated properly. Try changing something in `Dockerfile`
## Last ones executed:

- `docker buildx build --platform linux/amd64,linux/arm64 --builder container --push . -t 579859358947.dkr.ecr.us-east-1.amazonaws.com/as-platform/jre-17:latest -t 579859358947.dkr.ecr.us-east-1.amazonaws.com/as-platform/jre-17:0.0.12`
- `docker buildx build --platform linux/amd64,linux/arm64 --builder container --push . -t 579859358947.dkr.ecr.us-east-1.amazonaws.com/as-platform/jre-21:latest -t 579859358947.dkr.ecr.us-east-1.amazonaws.com/as-platform/jre-21:0.0.12`
- `docker buildx build --platform linux/amd64,linux/arm64 --builder container --push . -t 579859358947.dkr.ecr.us-east-1.amazonaws.com/as-platform/nginx-custom:latest -t 579859358947.dkr.ecr.us-east-1.amazonaws.com/as-platform/nginx-custom:0.0.13`