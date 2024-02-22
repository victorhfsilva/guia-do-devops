## Vinculando um pull request a uma issue usando uma palavra-chave

Você pode vincular um pull request a uma issue usando uma palavra-chave suportada na descrição do pull request ou em uma mensagem de commit. O pull request deve estar no branch padrão.

close
closes
closed
fix
fixes
fixed
resolve
resolves
resolved

A sintaxe para as palavras-chave de fechamento depende se a issue está no mesmo repositório que o pull request.


| Linked issue                  | Syntax                            | Example                          |
|------------------------------|-----------------------------------|----------------------------------|
| Issue in the same repository  | KEYWORD #ISSUE-NUMBER             | Closes #10                       |
| Issue in a different repository | KEYWORD OWNER/REPOSITORY#ISSUE-NUMBER | Fixes octo-org/octo-repo#100   |
| Multiple issues               | Use full syntax for each issue    | Resolves #10, resolves #123, resolves octo-org/octo-repo#100 |

Apenas pull requests vinculados manualmente podem ser desvinculados manualmente. Para desvincular uma issue que você vinculou usando uma palavra-chave, você deve editar a descrição do pull request para remover a palavra-chave.

Você também pode usar palavras-chave de fechamento em uma mensagem de commit. A issue será fechada quando você mesclar o commit no branch padrão, mas o pull request que contém o commit não será listado como um pull request vinculado.

## Referência

Github Docs: https://docs.github.com/en/issues/tracking-your-work-with-issues/linking-a-pull-request-to-an-issue