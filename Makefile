# Переменные
TF = terraform
COM-DEV = -var-file=terraform.tfvars.dev
COM-PROD = -var-file=terraform.tfvars.prod
AA = -auto-approve

init:
	$(TF) init -backend-config=backend-dev.hcl -reconfigure || true

init-all: init
	$(TF) workspace new dev || true
	$(TF) init -backend-config=backend-prod.hcl -reconfigure || true
	$(TF) workspace new prod || true

dev:
	$(TF) workspace select dev

prod:
	$(TF) workspace select prod

dev-plan: dev
	$(TF) plan $(COM-DEV)

dev-apply: dev
	$(TF) apply $(COM-DEV) $(AA)

dev-plan-d: dev
	$(TF) plan -destroy $(COM-DEV)

dev-destroy: dev
	$(TF) destroy $(COM-DEV) $(AA)

prod-plan: prod
	$(TF) plan $(COM-PROD)

prod-apply: prod
	$(TF) apply $(COM-PROD) $(AA)

prod-plan-d: prod
	$(TF) plan -destroy $(COM-PROD)

prod-destroy: prod
	$(TF) destroy $(COM-PROD) $(AA)

help:
	@echo "Доступные команды:"
	@echo "  init           - Инициализировать проект"
	@echo "  init-all       - Инициализировать проект и создать workspace"
	@echo "  dev            - Переключиться на dev workspace"
	@echo "  dev-plan       - Проверить dev изменения"
	@echo "  dev-apply      - Применить/запустить dev"
	@echo "  dev-plan-d     - Проверить перед удалением dev"
	@echo "  dev-destroy    - Удалить ресурсы dev"
	@echo "  prod           - Переключиться на prod workspace"
	@echo "  prod-plan      - Проверить prod изменения"
	@echo "  prod-apply     - Применить/запустить prod"
	@echo "  prod-plan-d    - Проверить перед удалением prod"
	@echo "  prod-destroy   - Удалить ресурсы prod"
