use v5.34;

my $tmpl = <<EOF;
package {pkg}

import "testing"

func Test{pkgUpper}(t *testing.T) {
}
EOF

for my $pkgname ('a'..'z') {
    my $body = $tmpl;
    $body =~ s/{pkg}/$pkgname/eg;
    $body =~ s/{pkgUpper}/uc($pkgname)/eg;
    mkdir $pkgname, 0755 or die $!;
    open my $fh, '>', "$pkgname/mod_test.go" or die $!;
    print $fh $body;
    close($fh);
}
